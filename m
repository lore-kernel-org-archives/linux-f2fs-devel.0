Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90562C52D7B
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 14 Aug 2024 02:32:54 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1se3ok-0007ub-8b;
	Wed, 14 Aug 2024 02:32:54 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <lihongbo22@huawei.com>) id 1se3oi-0007uR-Ls
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 14 Aug 2024 02:32:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :References:In-Reply-To:Message-ID:Date:Subject:CC:To:From:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=nrWKhm2avrdDmD+lS0/OoZu+YGyqVUWFs0OjZq3AAH8=; b=CDUQDdtXVvRJPLgVUJYJUcNND/
 S70uayvV3a5p2oIlQoNLCTmOBICCvuxB2l1RbnEc/MHK+z5w9KsymQdqxCEa9fsKWwTIuWZ4IGGP8
 slMt8GHmySfLWCLRq2/ZeQwBLYQ9TK4P37JchT9c4QyB49eWJUjFeE0Jf5H64tDZ605U=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:CC:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=nrWKhm2avrdDmD+lS0/OoZu+YGyqVUWFs0OjZq3AAH8=; b=ZP9myHCoE5mV5Uu/U8vOip1ZLt
 y0OYyzH/8O0BacTf7RjzJd5y6nV4ev97DboJMdsnD+MHKT5rLOYJQCgSyI1nO2tVs8gNfD1GkjQyC
 5gAskFcF9WNDlw/cFIzbGjJip90LsApLF9nDtg/Cl0m9AKgjR4CuZExRPOyUa2yvbhA0=;
Received: from szxga03-in.huawei.com ([45.249.212.189])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1se3oh-0005VH-NC for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 14 Aug 2024 02:32:52 +0000
Received: from mail.maildlp.com (unknown [172.19.88.194])
 by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4WkBxd5NRrzQpmg;
 Wed, 14 Aug 2024 10:28:05 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
 by mail.maildlp.com (Postfix) with ESMTPS id C16E61400C9;
 Wed, 14 Aug 2024 10:32:39 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpeml500022.china.huawei.com
 (7.185.36.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 14 Aug
 2024 10:32:39 +0800
To: <jaegeuk@kernel.org>, <chao@kernel.org>
Date: Wed, 14 Aug 2024 10:39:10 +0800
Message-ID: <20240814023912.3959299-8-lihongbo22@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240814023912.3959299-1-lihongbo22@huawei.com>
References: <20240814023912.3959299-1-lihongbo22@huawei.com>
MIME-Version: 1.0
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500022.china.huawei.com (7.185.36.66)
X-Headers-End: 1se3oh-0005VH-NC
Subject: [f2fs-dev] [PATCH 7/9] f2fs: introduce fs_context_operation
 structure
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
From: Hongbo Li via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Hongbo Li <lihongbo22@huawei.com>
Cc: linux-fsdevel@vger.kernel.org, lczerner@redhat.com, brauner@kernel.org,
 lihongbo22@huawei.com, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

The handle_mount_opt() helper is used to parse mount parameters,
and so we can rename this function to f2fs_parse_param() and set
it as .param_param in fs_context_operations.

Signed-off-by: Hongbo Li <lihongbo22@huawei.com>
---
 fs/f2fs/super.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index f658d75f4bb7..8c43fbe092ff 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -896,7 +896,7 @@ static int f2fs_set_zstd_level(struct f2fs_fs_context *ctx, const char *str)
 #endif
 #endif
 
-static int handle_mount_opt(struct fs_context *fc, struct fs_parameter *param)
+static int f2fs_parse_param(struct fs_context *fc, struct fs_parameter *param)
 {
 	struct f2fs_fs_context *ctx = fc->fs_private;
 #ifdef CONFIG_F2FS_FS_COMPRESSION
@@ -1544,7 +1544,7 @@ static int parse_options(struct fs_context *fc, char *options)
 			param.key = key;
 			param.size = v_len;
 
-			ret = handle_mount_opt(fc, &param);
+			ret = f2fs_parse_param(fc, &param);
 			kfree(param.string);
 			if (ret < 0)
 				return ret;
@@ -5577,6 +5577,10 @@ static struct dentry *f2fs_mount(struct file_system_type *fs_type, int flags,
 	return mount_bdev(fs_type, flags, dev_name, data, f2fs_fill_super);
 }
 
+static const struct fs_context_operations f2fs_context_ops = {
+	.parse_param	= f2fs_parse_param,
+};
+
 static void kill_f2fs_super(struct super_block *sb)
 {
 	struct f2fs_sb_info *sbi = F2FS_SB(sb);
-- 
2.34.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
