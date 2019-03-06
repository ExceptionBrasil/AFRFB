namespace ValidadorFiscalAFRFB.Forms
{
    partial class ClieEForm42
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.label1 = new System.Windows.Forms.Label();
            this.tFileBox = new System.Windows.Forms.TextBox();
            this.btnOpenDialogFile = new System.Windows.Forms.Button();
            this.openFileDialog = new System.Windows.Forms.OpenFileDialog();
            this.btnValidarCliFor = new System.Windows.Forms.Button();
            this.progressBar = new System.Windows.Forms.ProgressBar();
            this.dgHeader = new System.Windows.Forms.DataGridView();
            this.dgDetail = new System.Windows.Forms.DataGridView();
            this.tableLayoutPanel1 = new System.Windows.Forms.TableLayoutPanel();
            this.flowLayoutPanel1 = new System.Windows.Forms.FlowLayoutPanel();
            ((System.ComponentModel.ISupportInitialize)(this.dgHeader)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.dgDetail)).BeginInit();
            this.tableLayoutPanel1.SuspendLayout();
            this.flowLayoutPanel1.SuspendLayout();
            this.SuspendLayout();
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(3, 0);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(46, 13);
            this.label1.TabIndex = 0;
            this.label1.Text = "Arquivo:";
            // 
            // tFileBox
            // 
            this.tFileBox.Location = new System.Drawing.Point(55, 3);
            this.tFileBox.Name = "tFileBox";
            this.tFileBox.ReadOnly = true;
            this.tFileBox.Size = new System.Drawing.Size(285, 20);
            this.tFileBox.TabIndex = 1;
            // 
            // btnOpenDialogFile
            // 
            this.btnOpenDialogFile.Location = new System.Drawing.Point(346, 3);
            this.btnOpenDialogFile.Name = "btnOpenDialogFile";
            this.btnOpenDialogFile.Size = new System.Drawing.Size(33, 23);
            this.btnOpenDialogFile.TabIndex = 2;
            this.btnOpenDialogFile.Text = "...";
            this.btnOpenDialogFile.UseVisualStyleBackColor = true;
            this.btnOpenDialogFile.Click += new System.EventHandler(this.btnOpenDialogFile_Click);
            // 
            // openFileDialog
            // 
            this.openFileDialog.FileName = "openFileDialog1";
            // 
            // btnValidarCliFor
            // 
            this.btnValidarCliFor.BackColor = System.Drawing.SystemColors.Control;
            this.btnValidarCliFor.FlatStyle = System.Windows.Forms.FlatStyle.Flat;
            this.btnValidarCliFor.Location = new System.Drawing.Point(385, 3);
            this.btnValidarCliFor.Name = "btnValidarCliFor";
            this.btnValidarCliFor.Size = new System.Drawing.Size(75, 23);
            this.btnValidarCliFor.TabIndex = 3;
            this.btnValidarCliFor.Text = "Validar";
            this.btnValidarCliFor.UseVisualStyleBackColor = false;
            this.btnValidarCliFor.Click += new System.EventHandler(this.btnValidarCliFor_Click);
            // 
            // progressBar
            // 
            this.progressBar.Location = new System.Drawing.Point(466, 3);
            this.progressBar.Name = "progressBar";
            this.progressBar.Size = new System.Drawing.Size(94, 23);
            this.progressBar.TabIndex = 4;
            // 
            // dgHeader
            // 
            this.dgHeader.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dgHeader.Dock = System.Windows.Forms.DockStyle.Fill;
            this.dgHeader.Location = new System.Drawing.Point(3, 152);
            this.dgHeader.Name = "dgHeader";
            this.dgHeader.Size = new System.Drawing.Size(794, 143);
            this.dgHeader.TabIndex = 5;
            this.dgHeader.CellClick += new System.Windows.Forms.DataGridViewCellEventHandler(this.dgHeader_CellContentClick);
            // 
            // dgDetail
            // 
            this.dgDetail.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.dgDetail.Dock = System.Windows.Forms.DockStyle.Fill;
            this.dgDetail.Location = new System.Drawing.Point(3, 301);
            this.dgDetail.Name = "dgDetail";
            this.dgDetail.Size = new System.Drawing.Size(794, 146);
            this.dgDetail.TabIndex = 6;
            // 
            // tableLayoutPanel1
            // 
            this.tableLayoutPanel1.ColumnCount = 1;
            this.tableLayoutPanel1.ColumnStyles.Add(new System.Windows.Forms.ColumnStyle(System.Windows.Forms.SizeType.Percent, 100F));
            this.tableLayoutPanel1.Controls.Add(this.flowLayoutPanel1, 0, 0);
            this.tableLayoutPanel1.Controls.Add(this.dgDetail, 0, 2);
            this.tableLayoutPanel1.Controls.Add(this.dgHeader, 0, 1);
            this.tableLayoutPanel1.Dock = System.Windows.Forms.DockStyle.Fill;
            this.tableLayoutPanel1.Location = new System.Drawing.Point(0, 0);
            this.tableLayoutPanel1.Name = "tableLayoutPanel1";
            this.tableLayoutPanel1.RowCount = 3;
            this.tableLayoutPanel1.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 33.33333F));
            this.tableLayoutPanel1.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 33.33333F));
            this.tableLayoutPanel1.RowStyles.Add(new System.Windows.Forms.RowStyle(System.Windows.Forms.SizeType.Percent, 33.33333F));
            this.tableLayoutPanel1.Size = new System.Drawing.Size(800, 450);
            this.tableLayoutPanel1.TabIndex = 7;
            // 
            // flowLayoutPanel1
            // 
            this.flowLayoutPanel1.Controls.Add(this.label1);
            this.flowLayoutPanel1.Controls.Add(this.tFileBox);
            this.flowLayoutPanel1.Controls.Add(this.btnOpenDialogFile);
            this.flowLayoutPanel1.Controls.Add(this.btnValidarCliFor);
            this.flowLayoutPanel1.Controls.Add(this.progressBar);
            this.flowLayoutPanel1.Dock = System.Windows.Forms.DockStyle.Fill;
            this.flowLayoutPanel1.Location = new System.Drawing.Point(3, 3);
            this.flowLayoutPanel1.Name = "flowLayoutPanel1";
            this.flowLayoutPanel1.Size = new System.Drawing.Size(794, 143);
            this.flowLayoutPanel1.TabIndex = 0;
            // 
            // ClieEForm42
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(800, 450);
            this.Controls.Add(this.tableLayoutPanel1);
            this.Name = "ClieEForm42";
            this.Text = "ClieEForm42";
            ((System.ComponentModel.ISupportInitialize)(this.dgHeader)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.dgDetail)).EndInit();
            this.tableLayoutPanel1.ResumeLayout(false);
            this.flowLayoutPanel1.ResumeLayout(false);
            this.flowLayoutPanel1.PerformLayout();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.TextBox tFileBox;
        private System.Windows.Forms.Button btnOpenDialogFile;
        private System.Windows.Forms.OpenFileDialog openFileDialog;
        private System.Windows.Forms.Button btnValidarCliFor;
        private System.Windows.Forms.ProgressBar progressBar;
        private System.Windows.Forms.DataGridView dgHeader;
        private System.Windows.Forms.DataGridView dgDetail;
        private System.Windows.Forms.TableLayoutPanel tableLayoutPanel1;
        private System.Windows.Forms.FlowLayoutPanel flowLayoutPanel1;
    }
}