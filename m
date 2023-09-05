Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 825AEC83F33
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  5 Sep 2023 00:33:56 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1qdK0w-0006hE-BC;
	Tue, 05 Sep 2023 00:33:53 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ebiggers@kernel.org>) id 1qdK0v-0006h3-04
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 05 Sep 2023 00:33:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=pCerLsb6v24qyJ6YXUl2LFo+FKPzJ7DZIPQXmjU31wY=; b=JYSBkaPdVETXEP8NUEHBCa8fiN
 y0DUAyunN2iQPPcr5r1swJZaOMzGjC9yMNZB/DlRNJqw2Ou6gYYpmx2OpFROrPEM0vd/khZrXfuI4
 KpfKDIHI3q0IO8k+ULUY09UI2+4lOmi288Et9Udv+O9mPaGcKsJKmP+4fwf95B/ZYH48=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=pCerLsb6v24qyJ6YXUl2LFo+FKPzJ7DZIPQXmjU31wY=; b=k
 XJWT1FMnJ02cRDYA9/hcKaBqKdWYDEWVmOTMYVUw88ud2wH1j2C4FMVB+dqJ4zDrV2+BEQXsk7d9a
 RChkNI1CE3oSEJ84jDwIISrOuCwjJk1hrLv6+XeoJCqy64b/efdN4MuqfDP/xl3Q4MmOcx8vuR6Io
 wGYuglAy3OsPj3oY=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1qdK0q-0002yK-Jy for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 05 Sep 2023 00:33:51 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 19A54602E2;
 Tue,  5 Sep 2023 00:33:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43F39C433C7;
 Tue,  5 Sep 2023 00:33:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1693874022;
 bh=JUO7xE/c+1mjaLvxjmNdDZXOHT1tOz7iofriQG5oJNw=;
 h=From:To:Cc:Subject:Date:From;
 b=c/3Fo3AyhEldHIMOuXzoXgBkuXy6FNQV1zWaV1EXbsNHqgJEkqxqhz6A+uwueu6Sg
 9nnKKCU864zD1JUxT7xuR+3YVskJVwJx2Jyqe7j6jWMlfWbbIcKkKERT2VL6MUV3Gt
 1t0EbW2ta+NI78z/BBN3aKgjmhMjuhGwZpjdU6ALxK7czlyMo/hxN2LoMH7BvcZOmL
 aUqEO9IpWNhXyr1fmbth13UKikUetvpyg5kMAdevcYtZs3yMOh64mNO6qcgZl+j2WI
 B3X5mpPmIdb9o+wIh0NP/LjeU8LoWHITSDOSSwWqpyViCMUJWS4K7ea7urzn+NCTuw
 ji+rFVGK+8kAg==
From: Eric Biggers <ebiggers@kernel.org>
To: Jan Kara <jack@suse.com>,
	linux-fscrypt@vger.kernel.org
Date: Mon,  4 Sep 2023 17:32:27 -0700
Message-ID: <20230905003227.326998-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
X-Headers-End: 1qdK0q-0002yK-Jy
Subject: [f2fs-dev] [PATCH] quota: explicitly forbid quota files from being
 encrypted
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
Cc: linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
 stable@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Eric Biggers <ebiggers@google.com>

Since commit d7e7b9af104c ("fscrypt: stop using keyrings subsystem for
fscrypt_master_key"), xfstest generic/270 causes a WARNING when run on
f2fs with test_dummy_encryption in the mount options:

$ kvm-xfstests -c f2fs/encrypt generic/270
[...]
WARNING: CPU: 1 PID: 2453 at fs/crypto/keyring.c:240 fscrypt_destroy_keyring+0x1f5/0x260

The cause of the WARNING is that not all encrypted inodes have been
evicted before fscrypt_destroy_keyring() is called, which violates an
assumption.  This happens because the test uses an external quota file,
which gets automatically encrypted due to test_dummy_encryption.

Encryption of quota files has never really been supported.  On ext4,
ext4_quota_read() does not decrypt the data, so encrypted quota files
are always considered invalid on ext4.  On f2fs, f2fs_quota_read() uses
the pagecache, so trying to use an encrypted quota file gets farther,
resulting in the issue described above being possible.  But this was
never intended to be possible, and there is no use case for it.

Therefore, make the quota support layer explicitly reject using
IS_ENCRYPTED inodes when quotaon is attempted.

Cc: stable@vger.kernel.org
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/quota/dquot.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/fs/quota/dquot.c b/fs/quota/dquot.c
index 9e72bfe8bbad9..7e268cd2727cc 100644
--- a/fs/quota/dquot.c
+++ b/fs/quota/dquot.c
@@ -2339,6 +2339,20 @@ static int vfs_setup_quota_inode(struct inode *inode, int type)
 	if (sb_has_quota_loaded(sb, type))
 		return -EBUSY;
 
+	/*
+	 * Quota files should never be encrypted.  They should be thought of as
+	 * filesystem metadata, not user data.  New-style internal quota files
+	 * cannot be encrypted by users anyway, but old-style external quota
+	 * files could potentially be incorrectly created in an encrypted
+	 * directory, hence this explicit check.  Some reasons why encrypted
+	 * quota files don't work include: (1) some filesystems that support
+	 * encryption don't handle it in their quota_read and quota_write, and
+	 * (2) cleaning up encrypted quota files at unmount would need special
+	 * consideration, as quota files are cleaned up later than user files.
+	 */
+	if (IS_ENCRYPTED(inode))
+		return -EINVAL;
+
 	dqopt->files[type] = igrab(inode);
 	if (!dqopt->files[type])
 		return -EIO;

base-commit: 708283abf896dd4853e673cc8cba70acaf9bf4ea
-- 
2.42.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
