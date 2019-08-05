Return-Path: <SRS0=Urpw=WB=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14477C0650F
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  5 Aug 2019 16:29:00 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D814E214C6;
	Mon,  5 Aug 2019 16:28:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="WMQbIJyd";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="Xu7MFoF5";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="yLJwOaMI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D814E214C6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1hufr1-0004iN-JA; Mon, 05 Aug 2019 16:28:59 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <ebiggers@kernel.org>) id 1hufqu-0004g0-B3
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 05 Aug 2019 16:28:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=IIx/O752PzRhZwL9LINWOrMvDb4n+KFU2oiBl+Kdnso=; b=WMQbIJydxYyv4OJYJL9vo4k2le
 YkPLce+8qGKmr7zggD6J20YGFjtByNOXPjClNHquF6+eeuA0PTDKiidi8aIHU6kOUz6aLy2a6kAbL
 LABveuLA4xFLdRKE6mUacm4B4f0wY40ZoNhojJX1ya6ErTAwlkpjMgT6xxlwXiONa1XQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=IIx/O752PzRhZwL9LINWOrMvDb4n+KFU2oiBl+Kdnso=; b=Xu7MFoF5ZsGJ4uNo7ipms7XdBW
 o4ziDTW8MUA1WU27AxzSNR+YNJGuNeI06d0zq6T72GWvTpiJBD/H6S0NcMhJ+uyntBmqiS3yyw7Er
 jp1rl7/Q5z+kw0cRWdOGUKOtYsm48Qwzw4tyr/cWUilIwodw/vruNqexkOBTDM1hDhyM=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hufqt-00BnL6-3Q
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 05 Aug 2019 16:28:52 +0000
Received: from ebiggers-linuxstation.mtv.corp.google.com (unknown
 [104.132.1.77])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 94DF72086D;
 Mon,  5 Aug 2019 16:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1565022520;
 bh=/PBGBXqE/EwxYsWcuLi1kOHq1m2hFPoiT4d+PrH3UkA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=yLJwOaMIhqTtAZpfXCSahL0GbsDxf2cMDZM6sDfJd42P7yRk3qZFgJ5Ct7YCSkhA9
 Owbwb0kxxbClJSVQ3vqOqrh7SyaNAkfI8NaNd4d7PGCVGf/vke31CaefcGnQeDz4rL
 JBJJfCEd21Lflsk19PjpG7OlMjN7frNQCq5L5eJ4=
From: Eric Biggers <ebiggers@kernel.org>
To: linux-fscrypt@vger.kernel.org
Date: Mon,  5 Aug 2019 09:25:20 -0700
Message-Id: <20190805162521.90882-20-ebiggers@kernel.org>
X-Mailer: git-send-email 2.22.0.770.g0f2c4a37fd-goog
In-Reply-To: <20190805162521.90882-1-ebiggers@kernel.org>
References: <20190805162521.90882-1-ebiggers@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1hufqt-00BnL6-3Q
Subject: [f2fs-dev] [PATCH v8 19/20] ubifs: wire up new fscrypt ioctls
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
Cc: Satya Tangirala <satyat@google.com>, Theodore Ts'o <tytso@mit.edu>,
 linux-api@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 keyrings@vger.kernel.org, linux-mtd@lists.infradead.org,
 linux-crypto@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 Jaegeuk Kim <jaegeuk@kernel.org>, linux-ext4@vger.kernel.org,
 Paul Crowley <paulcrowley@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Eric Biggers <ebiggers@google.com>

Wire up the new ioctls for adding and removing fscrypt keys to/from the
filesystem, and the new ioctl for retrieving v2 encryption policies.

The key removal ioctls also required making UBIFS use
fscrypt_drop_inode().

For more details see Documentation/filesystems/fscrypt.rst and the
fscrypt patches that added the implementation of these ioctls.

Reviewed-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/ubifs/ioctl.c | 20 ++++++++++++++++++++
 fs/ubifs/super.c | 11 +++++++++++
 2 files changed, 31 insertions(+)

diff --git a/fs/ubifs/ioctl.c b/fs/ubifs/ioctl.c
index 034ad14710d14a..5dc5abca11c704 100644
--- a/fs/ubifs/ioctl.c
+++ b/fs/ubifs/ioctl.c
@@ -185,6 +185,21 @@ long ubifs_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	case FS_IOC_GET_ENCRYPTION_POLICY:
 		return fscrypt_ioctl_get_policy(file, (void __user *)arg);
 
+	case FS_IOC_GET_ENCRYPTION_POLICY_EX:
+		return fscrypt_ioctl_get_policy_ex(file, (void __user *)arg);
+
+	case FS_IOC_ADD_ENCRYPTION_KEY:
+		return fscrypt_ioctl_add_key(file, (void __user *)arg);
+
+	case FS_IOC_REMOVE_ENCRYPTION_KEY:
+		return fscrypt_ioctl_remove_key(file, (void __user *)arg);
+
+	case FS_IOC_REMOVE_ENCRYPTION_KEY_ALL_USERS:
+		return fscrypt_ioctl_remove_key_all_users(file,
+							  (void __user *)arg);
+	case FS_IOC_GET_ENCRYPTION_KEY_STATUS:
+		return fscrypt_ioctl_get_key_status(file, (void __user *)arg);
+
 	default:
 		return -ENOTTY;
 	}
@@ -202,6 +217,11 @@ long ubifs_compat_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 		break;
 	case FS_IOC_SET_ENCRYPTION_POLICY:
 	case FS_IOC_GET_ENCRYPTION_POLICY:
+	case FS_IOC_GET_ENCRYPTION_POLICY_EX:
+	case FS_IOC_ADD_ENCRYPTION_KEY:
+	case FS_IOC_REMOVE_ENCRYPTION_KEY:
+	case FS_IOC_REMOVE_ENCRYPTION_KEY_ALL_USERS:
+	case FS_IOC_GET_ENCRYPTION_KEY_STATUS:
 		break;
 	default:
 		return -ENOIOCTLCMD;
diff --git a/fs/ubifs/super.c b/fs/ubifs/super.c
index 2c0803b0ac3aa2..3ad6620f14fb81 100644
--- a/fs/ubifs/super.c
+++ b/fs/ubifs/super.c
@@ -318,6 +318,16 @@ static int ubifs_write_inode(struct inode *inode, struct writeback_control *wbc)
 	return err;
 }
 
+static int ubifs_drop_inode(struct inode *inode)
+{
+	int drop = generic_drop_inode(inode);
+
+	if (!drop)
+		drop = fscrypt_drop_inode(inode);
+
+	return drop;
+}
+
 static void ubifs_evict_inode(struct inode *inode)
 {
 	int err;
@@ -1990,6 +2000,7 @@ const struct super_operations ubifs_super_operations = {
 	.free_inode    = ubifs_free_inode,
 	.put_super     = ubifs_put_super,
 	.write_inode   = ubifs_write_inode,
+	.drop_inode    = ubifs_drop_inode,
 	.evict_inode   = ubifs_evict_inode,
 	.statfs        = ubifs_statfs,
 	.dirty_inode   = ubifs_dirty_inode,
-- 
2.22.0.770.g0f2c4a37fd-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
