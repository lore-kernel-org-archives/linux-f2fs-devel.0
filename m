From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH] f2fs: Fix a return value in case of error in 'f2fs_fill_super'
Date: Sun, 11 Jun 2017 09:21:11 +0200
Message-ID: <20170611072111.2293-1-christophe.jaillet@wanadoo.fr>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org, yuchao0@huawei.com
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, Christophe JAILLET <christophe.jaillet@wanadoo.fr>
List-Id: linux-f2fs-devel.lists.sourceforge.net

err must be set to -ENOMEM, otherwise we return 0.

Fixes: a912b54d3aaa0 ("f2fs: split bio cache")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 fs/f2fs/super.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 5be27eacea99..38f1624ac5dc 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1976,8 +1976,10 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 
 		sbi->write_io[i] = kmalloc(n * sizeof(struct f2fs_bio_info),
 								GFP_KERNEL);
-		if (!sbi->write_io[i])
+		if (!sbi->write_io[i]) {
+			err = -ENOMEM;
 			goto free_options;
+		}
 
 		for (j = HOT; j < n; j++) {
 			init_rwsem(&sbi->write_io[i][j].io_rwsem);
-- 
2.11.0
