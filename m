From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH v2] f2fs: relax migratepage for atomic written page
Date: Thu, 6 Jul 2017 14:49:26 -0700
Message-ID: <20170706214926.GB395@jaegeuk-macbookpro.roam.corp.google.com>
References: <20170703230820.63929-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170703230820.63929-1-jaegeuk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

In order to avoid lock contention for atomic written pages, we'd better give
EBUSY in f2fs_migrate_page when mode is asynchronous. We expect it will be
released soon as transaction commits.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---

Change log from v1:
 - return -EBUSY when mode is MIGRATE_ASYNC or MIGRATE_SYNC_LIGHT

 fs/f2fs/data.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 85ac3a63cce6..74c31cb203e2 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2206,8 +2206,12 @@ int f2fs_migrate_page(struct address_space *mapping,
 	BUG_ON(PageWriteback(page));
 
 	/* migrating an atomic written page is safe with the inmem_lock hold */
-	if (atomic_written && !mutex_trylock(&fi->inmem_lock))
-		return -EAGAIN;
+	if (atomic_written) {
+		if (mode != MIGRATE_SYNC)
+			return -EBUSY;
+		if (!mutex_trylock(&fi->inmem_lock))
+			return -EAGAIN;
+	}
 
 	/*
 	 * A reference is expected if PagePrivate set when move mapping,
-- 
2.13.0.rc1.294.g07d810a77f-goog
