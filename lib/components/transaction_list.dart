import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final void Function(String) onRemove;

  const TransactionList(this.transactions, this.onRemove);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.4,
      child: transactions.isEmpty
          ? LayoutBuilder(
            builder: (ctx, constraints) {
              return Column(
                children: <Widget>[
                  SizedBox(height: constraints.maxHeight * 0.05),
                  SizedBox(
                    height: constraints.maxHeight * 0.2,
                    child: Text(
                      'Nenhuma Transação Cadastrada!',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                  SizedBox(height: constraints.maxHeight * 0.05),
                  SizedBox(
                    height: constraints.maxHeight * 0.5,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              );
            },
          )
          : ListView.builder(
            itemCount: transactions.length,
            itemBuilder: (ctx, index) {
              final tr = transactions[index];
              return Card(
                elevation: 5,
                margin: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 5
                ),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                      child: Padding(
                        padding: const EdgeInsets.all(6),
                        child: FittedBox(
                            child: Text('R\$ ${tr.value}')
                        ),
                      ),
                  ),
                  title: Text(
                    tr.title,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  subtitle: Text(
                    DateFormat('d MMM y').format(tr.date)
                  ),
                  trailing: MediaQuery.of(context).size.width > 400
                      ? TextButton.icon(
                        onPressed: () => onRemove(tr.id),
                        icon: const Icon(Icons.delete),
                        label: const Text('Excluir'),
                      )
                      : IconButton(
                        icon: const Icon(Icons.delete),
                        color: Theme.of(context).errorColor,
                        onPressed: () => onRemove(tr.id),
                      ),
                ),
              );
            },
          ),
      );
  }
}

