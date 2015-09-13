From: Julia Lawall <Julia.Lawall@lip6.fr>
Subject: [PATCH 37/39] f2fs crypto: drop null test before destroy functions
Date: Sun, 13 Sep 2015 14:15:30 +0200
Message-ID: <1442146532-9100-38-git-send-email-Julia.Lawall@lip6.fr>
References: <1442146532-9100-1-git-send-email-Julia.Lawall@lip6.fr>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1442146532-9100-1-git-send-email-Julia.Lawall@lip6.fr>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: sergey.senozhatsky@gmail.com, kernel-janitors@vger.kernel.org, Changman Lee <cm224.lee@samsung.com>, Chao Yu <chao2.yu@samsung.com>, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

Remove unneeded NULL test.

The semantic patch that makes this change is as follows:
(http://coccinelle.lip6.fr/)

// <smpl>
@@ expression x; @@
-if (x != NULL)
  \(kmem_cache_destroy\|mempool_destroy\|dma_pool_destroy\)(x);
// </smpl>

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 fs/f2fs/crypto.c |    9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/crypto.c b/fs/f2fs/crypto.c
index 4a62ef1..3c27f04 100644
--- a/fs/f2fs/crypto.c
+++ b/fs/f2fs/crypto.c
@@ -183,8 +183,7 @@ static void f2fs_crypto_destroy(void)
 	list_for_each_entry_safe(pos, n, &f2fs_free_crypto_ctxs, free_list)
 		kmem_cache_free(f2fs_crypto_ctx_cachep, pos);
 	INIT_LIST_HEAD(&f2fs_free_crypto_ctxs);
-	if (f2fs_bounce_page_pool)
-		mempool_destroy(f2fs_bounce_page_pool);
+	mempool_destroy(f2fs_bounce_page_pool);
 	f2fs_bounce_page_pool = NULL;
 }
 
@@ -240,10 +239,8 @@ void f2fs_exit_crypto(void)
 
 	if (f2fs_read_workqueue)
 		destroy_workqueue(f2fs_read_workqueue);
-	if (f2fs_crypto_ctx_cachep)
-		kmem_cache_destroy(f2fs_crypto_ctx_cachep);
-	if (f2fs_crypt_info_cachep)
-		kmem_cache_destroy(f2fs_crypt_info_cachep);
+	kmem_cache_destroy(f2fs_crypto_ctx_cachep);
+	kmem_cache_destroy(f2fs_crypt_info_cachep);
 }
 
 int __init f2fs_init_crypto(void)
