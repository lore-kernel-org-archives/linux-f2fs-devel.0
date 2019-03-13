From: kbuild test robot <lkp@intel.com>
Subject: [RFC PATCH f2fs] f2fs: f2fs_submit_ipu_bio() can be
 static
Date: Thu, 14 Mar 2019 07:53:58 +0800
Message-ID: <20190313235358.GA47610@lkp-kbuild04>
References: <201903140706.NPV5nM0E%lkp@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <lkp@intel.com>) id 1h4Dhj-00048p-Dv
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 13 Mar 2019 23:54:35 +0000
Received: from mga06.intel.com ([134.134.136.31])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1h4Dhh-00GvPE-CE
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 13 Mar 2019 23:54:35 +0000
Content-Disposition: inline
In-Reply-To: <201903140706.NPV5nM0E%lkp@intel.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Chao Yu <yuchao0@huawei.com>, Chao Yu <chao@kernel.org>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, kbuild-all@01.org, linux-f2fs-devel@lists.sourceforge.net


Fixes: 60686faa1e20 ("f2fs: add bio cache for IPU")
Signed-off-by: kbuild test robot <lkp@intel.com>
---
 data.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 6908469..9381f76 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -517,7 +517,7 @@ int f2fs_merge_page_bio(struct f2fs_io_info *fio)
 	return 0;
 }
 
-void f2fs_submit_ipu_bio(struct f2fs_sb_info *sbi, struct bio **bio,
+static void f2fs_submit_ipu_bio(struct f2fs_sb_info *sbi, struct bio **bio,
 							struct page *page)
 {
 	if (!bio)
