Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CEA0606A332
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 18 Nov 2026 00:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=dFUxW81b;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=FdKIzocp;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=SEToZD0Q;
	dkim=neutral header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Nk16DLld
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=M5YTMQDDcb59apXuHwKP8fjqL1X5xro5mZz4PbRcIF8=; b=dFUxW81b+/Wa6MFNlnhVh7jf5i
	F7hsH8D1sgW4LRk52lwPPNEDb2vQsRwcsPb0CAvGRla6TSaFJpq7VNggkjd30Hlcih9eTbXOkYAIY
	KEetH7x4oyhF8s8oSHHd16RoUd+ZelGXkrFxZ07tv5+E2j8h4WXiYIVEXsAwoYlfsEJM=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xTTYd-000000006rl-0zkB;
	Wed, 18 Nov 2026 00:29:51 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <blum@kernel.org>) id 1xTTYc-000000006rd-37IU
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 18 Nov 2026 00:29:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Qt60u/01NFUb/AYhVxHzrtbOvOOGfTfWBLgqtTss5Z0=; b=FdKIzocpYwskYQJALcbHcHJZqi
 hePXEULWyHHSnswxxkktABDiFmLuk/1xwUmxn5GT00UpnVaXqXSoW3ozrdGLD539XtIjTYXwpbk4y
 nvovcoJcAAbAiwSBJN95bT0RdmBTtcUnfNHZ7h05N2QW/vv3Wp39/QH8BCERxqX5z74A=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Qt60u/01NFUb/AYhVxHzrtbOvOOGfTfWBLgqtTss5Z0=; b=SEToZD0QClTMS261fihT61Lb5R
 akq0v7O+6xMD7OvsFZV10EHkHM+vAQrmO9mXK3jFixIImk151ArJDtH/GXyT24j6tj69m0LATIRl5
 ySbcoS5P9gIgewm/1qM+woA1mv0Dbhdxp8pVPl1/B6fFJHdvm34PlHi9/zT3mqBncDIw=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xTTYc-000000005hm-0xgJ
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 18 Nov 2026 00:29:50 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A5C1B611E4;
 Wed, 18 Nov 2026 00:29:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CF291F000CA;
 Wed, 18 Nov 2026 00:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794961784;
 bh=Qt60u/01NFUb/AYhVxHzrtbOvOOGfTfWBLgqtTss5Z0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Nk16DLldu3/i9fxqzBvs7WbOc2fj5wTFODes7aYf9CJn9LQZy8P4T8RCtAqmun3w3
 8S5zvFrpuV58qdUQqwfBUXhmfKWBBfuVTBkfdYUE66lqYSFjCqV9WMI2HIi6ahl8gM
 Dxi/MXuzgrA2hS733BiZZKsBVTG8aqOrKAVQYo5FH3lxScFwuzy5NyVaZn/c3W+DAZ
 /rrxYoBTfVV4mtvcdW2iDEO3qs5Z1DwG94mpdz7JZpAG9Pt+4N1mwqk2Ut0OB2zedT
 j4TK84yyaHmrQqdukeVOk6Y1WWZ0tfPT3tikxqN1Qr1BZ4sCQAc9dZ+DqMTc/MKGAW
 BM4Wis3M20cmQ==
To: David Sterba <dsterba@suse.com>, Chris Mason <mason@kernel.org>,
 Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
 Richard Weinberger <richard@nod.at>,
 Zhihao Cheng <chengzhihao1@huawei.com>, Eric Biggers <ebiggers@kernel.org>,
 "Theodore Y. Ts'o" <tytso@mit.edu>
Date: Wed, 18 Nov 2026 01:28:48 +0100
Message-ID: <20261118002845.574426-8-blum@kernel.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261118002845.574426-6-blum@kernel.org>
References: <20261118002845.574426-6-blum@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2827; i=blum@kernel.org;
 h=from:subject; bh=C5PvMKO+6yQo+bVlkdY4gYEIvoCwjLB1zuR+7E63A20=;
 b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFl/Ptq1zPv2VvVsMH+cXGqFUv7t04UVn/a/sYrbkPs08
 rr3qs6DHaUsDGJcDLJiiiwPZv2Y4VtaU7nJJGInzBxWJpAhDFycAjCRqpOMDG9mrb3o3LUvRezg
 olKvBGOToHTri6VNm5f/qPv1/4lygQbDP5PYuAX8bYciMvUs+lp59R1UVZovTdG/67Gx2KH1rVg
 uEwA=
X-Developer-Key: i=blum@kernel.org; a=openpgp;
 fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xTTYc-000000005hm-0xgJ
Subject: [f2fs-dev] [PATCH 2/4] btrfs: Use FSTR() for the "default" name
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
From: Thorsten Blum via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Thorsten Blum <blum@kernel.org>
Cc: Thorsten Blum <blum@kernel.org>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-fscrypt@vger.kernel.org,
 linux-mtd@lists.infradead.org, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Replace FSTR_INIT() with FSTR() and drop the hard-coded length argument.

Use FSTR() directly and remove the temporary name variables.

Signed-off-by: Thorsten Blum <blum@kernel.org>
---
 fs/btrfs/inode.c | 3 +--
 fs/btrfs/ioctl.c | 3 +--
 fs/btrfs/super.c | 3 +--
 3 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index abaa33471456..1ffdcdd16bb5 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -4640,7 +4640,6 @@ static noinline int may_destroy_subvol(struct btrfs_root *root)
 	BTRFS_PATH_AUTO_FREE(path);
 	struct btrfs_dir_item *di;
 	struct btrfs_key key;
-	struct fscrypt_str name = FSTR_INIT("default", 7);
 	u64 dir_id;
 	int ret;
 
@@ -4651,7 +4650,7 @@ static noinline int may_destroy_subvol(struct btrfs_root *root)
 	/* Make sure this root isn't set as the default subvol */
 	dir_id = btrfs_super_root_dir(fs_info->super_copy);
 	di = btrfs_lookup_dir_item(NULL, fs_info->tree_root, path,
-				   dir_id, &name, 0);
+				   dir_id, &FSTR("default"), 0);
 	if (!IS_ERR_OR_NULL(di)) {
 		btrfs_dir_item_key_to_cpu(path->nodes[0], di, &key);
 		if (key.objectid == btrfs_root_id(root)) {
diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
index 6ba883db107b..6c371621f014 100644
--- a/fs/btrfs/ioctl.c
+++ b/fs/btrfs/ioctl.c
@@ -2825,7 +2825,6 @@ static long btrfs_ioctl_default_subvol(struct file *file, void __user *argp)
 	struct btrfs_trans_handle *trans;
 	struct btrfs_path *path = NULL;
 	struct btrfs_disk_key disk_key;
-	struct fscrypt_str name = FSTR_INIT("default", 7);
 	u64 objectid = 0;
 	u64 dir_id;
 	int ret;
@@ -2869,7 +2868,7 @@ static long btrfs_ioctl_default_subvol(struct file *file, void __user *argp)
 
 	dir_id = btrfs_super_root_dir(fs_info->super_copy);
 	di = btrfs_lookup_dir_item(trans, fs_info->tree_root, path,
-				   dir_id, &name, 1);
+				   dir_id, &FSTR("default"), 1);
 	if (IS_ERR_OR_NULL(di)) {
 		btrfs_release_path(path);
 		btrfs_end_transaction(trans);
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index b424cc836bd4..0b8b808872c7 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -911,7 +911,6 @@ static int get_default_subvol_objectid(struct btrfs_fs_info *fs_info, u64 *objec
 	struct btrfs_dir_item *di;
 	BTRFS_PATH_AUTO_FREE(path);
 	struct btrfs_key location;
-	struct fscrypt_str name = FSTR_INIT("default", 7);
 	u64 dir_id;
 
 	path = btrfs_alloc_path();
@@ -924,7 +923,7 @@ static int get_default_subvol_objectid(struct btrfs_fs_info *fs_info, u64 *objec
 	 * to mount.
 	 */
 	dir_id = btrfs_super_root_dir(fs_info->super_copy);
-	di = btrfs_lookup_dir_item(NULL, root, path, dir_id, &name, 0);
+	di = btrfs_lookup_dir_item(NULL, root, path, dir_id, &FSTR("default"), 0);
 	if (IS_ERR(di)) {
 		return PTR_ERR(di);
 	}


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
