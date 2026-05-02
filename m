Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E9F0CD13DA
	for <linux-f2fs-devel@archiver.kernel.org>; Sat,  2 May 2026 14:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:In-Reply-To:References:Message-Id:
	MIME-Version:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MYIxfse7nBbPnf+GPaVmEpIo39we5icR35gMwhK2/8M=; b=PpsYQGV53Ckm7Hppa1i2mCzCR+
	+ECe/n+vIcs28CnJz3oTzYQwDVBtdRSPTfBxYopB4VzUXmkim9Qi4Zy8lR3aidFF2us5uMG2lSmgl
	IxjQAcQsQX3J/f+osYDWtGSdPRXM9++Qp57rjQhZny/xHFQpbYUAAxZqwzwlrq3ixPgc=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wJBEM-0002iv-O2;
	Sat, 02 May 2026 14:22:06 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <cel@kernel.org>) id 1wJBEK-0002ip-Uw
 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 02 May 2026 14:22:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Message-Id:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=VhvxauimFK5NAhqFYc67ug8slC/9/uxvMYlNbME097o=; b=gkZPeW9ap31PbU+AD7aGaHrI44
 ylS1TiNTpWeW/tiTfX1MsqOgWoEAnV1D8Tgv6F8FwUpzuRcxA3P7lBjnSxdULTxzQcE45NdBlCN9L
 49hPci/h8yN7LxK8TgE4VZOkRdkLx+zmcDZvaj4NjTflhcMYik8KiBocJuRVeLJLEYA8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Cc:To:In-Reply-To:References:Message-Id:Content-Transfer-Encoding:
 Content-Type:MIME-Version:Subject:Date:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=VhvxauimFK5NAhqFYc67ug8slC/9/uxvMYlNbME097o=; b=kZoItprmNJn4LY5GtSo5wDSKap
 JXkcdlI5Fd6aQePMuByeeniQzMLMOIeE4/xkiJnaMQST6BNxe3q0eMUzY9dAI33kMw/PjJGHlx/fH
 MVWw50/rZM1rDhjw37+2Kn5FdjjR2WsbdV6hlvjPheHkeXDE31Yn0y/Q6VbMICQuw0dw=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wJBEK-0000uJ-Cs for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 02 May 2026 14:22:04 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id C9F9560120;
 Sat,  2 May 2026 14:21:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03A4AC2BCB3;
 Sat,  2 May 2026 14:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777731713;
 bh=MCKLEZC7Qx1FnQ0cZy8w8gaJqor/Oy2yvhPP57H1cWo=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=iGtBLUSF+6X2+9FyfJCet7RcIGjsQ3/QE4Aelk7z9F9oqSLPGRLUmlD+WDl7G7DQh
 UZUnxHQt63NbC+WeuPZkxp1xdYeb/qOyNjy7YnE6ULTlNC6EK/Vfe307gS3hJ8KsNx
 vg7H0N/4BWWW+EIg7RAUdwnhkbiKSSyB3cxCaJziQxhFSEkw5V0ut0EtzW8abXqG63
 jo+zTkn7De+sC4BD2+XbqsP+WeJCTcyVM+G4/H9PLfN9mWPqMUDY7yIXQDEBCWrlvp
 I4mvT1CgArb3YDqxqTjldCtRFJF4/Ei+xNd8u3CqVI/nYhejChEYv2m5Y/kcxZdynp
 nKvV7GCBPmS3g==
Date: Sat, 02 May 2026 10:20:52 -0400
MIME-Version: 1.0
Message-Id: <20260502-case-sensitivity-v13-7-aa853140311f@oracle.com>
References: <20260502-case-sensitivity-v13-0-aa853140311f@oracle.com>
In-Reply-To: <20260502-case-sensitivity-v13-0-aa853140311f@oracle.com>
To: Al Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2621;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=yr1QdNRA2c3h2NX2KtSKVIgsso0huI4pF/+aMWQ1VYs=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBp9ghQXlTy0BV79mXGcUu0Hfjx8S0jG9arjDr7z
 y6V7cr4KwmJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCafYIUAAKCRAzarMzb2Z/
 l07AD/9Iq3bdIv0k7pytSc+UdefTTkptZ2WriQF+ImjlXqgQbAMmyNasFaC7/WT2D/RQV7iYcI+
 GE9iydJujgjH5Q5/Ks9Y/zjEf7qZVJQgRW+g0ogLjyYHEY0dPlAuTEuX4+Vx/DuXVubV/N4udMZ
 tksioir7JVT8BNvcoFzL/MtNvTdn8TB5HfSCZU1iEaYYjxMI37lBPrY+odoEg0FeUzw73pYz3fd
 RpphpprtcwAmLS5giRpLc+FFjRKA2Qh7oRZZr9ETpLsl6DUIp50HQiwXW3HvwN87BLu/ElWvik6
 9kT9LJmr9jQxVClZkO991RjXjiepcmQGeKKQB+FMDYd+IWAjl4ppIDim99PfhoaFD8mJKlF4rLI
 56dyyaaktsD3pExexfZmz/nkVyvYfyYymJAv6HmYXlmB0JM0my23hOlS0fezX39q/8uzcOK0HTv
 X3n9vabqmn10QM6fZQP/n1Mx6oW57grHrOV47pOCJKSzI9d+VjqHqCMHZk5CuC6Njb1yckj3mJL
 UbKVHRavZI7n68qX1cxu8xO8uzJJiNFxaQIQv4Yzwp92qVJhBrR/opfxJal/+FTwgvD/Z3yGSYd
 JkUXiIsXCyJAbiLN/6f0ELx0/o1mxhv6JpQ42feNivM7Aijj0WTnWsPI186WOyMBY7fHl6IGS6C
 rGtgsWvnogTc39Q==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97
X-Headers-End: 1wJBEK-0000uJ-Cs
Subject: [f2fs-dev] [PATCH v13 07/15] hfsplus: Report case sensitivity in
 fileattr_get
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
From: Chuck Lever via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Chuck Lever <cel@kernel.org>
Cc: pc@manguebit.org, yuezhang.mo@sony.com, cem@kernel.org,
 Roland Mainz <roland.mainz@nrubsig.org>,
 almaz.alexandrovich@paragon-software.com, adilger.kernel@dilger.ca,
 linux-cifs@vger.kernel.org, sfrench@samba.org, slava@dubeyko.com,
 linux-ext4@vger.kernel.org, linkinjeon@kernel.org, sprasad@microsoft.com,
 frank.li@vivo.com, ronniesahlberg@gmail.com, glaubitz@physik.fu-berlin.de,
 jaegeuk@kernel.org, hirofumi@mail.parknet.co.jp, linux-nfs@vger.kernel.org,
 tytso@mit.edu, linux-api@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
 senozhatsky@chromium.org, Chuck Lever <chuck.lever@oracle.com>,
 hansg@kernel.org, anna@kernel.org, linux-fsdevel@vger.kernel.org,
 sj1557.seo@samsung.com, trondmy@kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Chuck Lever <chuck.lever@oracle.com>

Add case sensitivity reporting to the existing hfsplus_fileattr_get()
function via the FS_XFLAG_CASEFOLD flag. HFS+ always preserves case
at rest.

Case sensitivity depends on how the volume was formatted: HFSX
volumes may be either case-sensitive or case-insensitive, indicated
by the HFSPLUS_SB_CASEFOLD superblock flag.

FS_XFLAG_CASEFOLD is read-only: FS_XFLAG_RDONLY_MASK ensures
FS_IOC_FSSETXATTR strips it. The legacy FS_IOC_SETFLAGS path in
hfsplus_fileattr_set() also allows FS_CASEFOLD_FL through its
allowlist on case-insensitive volumes so that a chattr
read-modify-write cycle does not fail with EOPNOTSUPP.

Reviewed-by: Viacheslav Dubeyko <slava@dubeyko.com>
Reviewed-by: Roland Mainz <roland.mainz@nrubsig.org>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/hfsplus/inode.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/fs/hfsplus/inode.c b/fs/hfsplus/inode.c
index d05891ec492e..5565c14b4bf6 100644
--- a/fs/hfsplus/inode.c
+++ b/fs/hfsplus/inode.c
@@ -740,6 +740,7 @@ int hfsplus_fileattr_get(struct dentry *dentry, struct file_kattr *fa)
 {
 	struct inode *inode = d_inode(dentry);
 	struct hfsplus_inode_info *hip = HFSPLUS_I(inode);
+	struct hfsplus_sb_info *sbi = HFSPLUS_SB(inode->i_sb);
 	unsigned int flags = 0;
 
 	if (inode->i_flags & S_IMMUTABLE)
@@ -748,6 +749,8 @@ int hfsplus_fileattr_get(struct dentry *dentry, struct file_kattr *fa)
 		flags |= FS_APPEND_FL;
 	if (hip->userflags & HFSPLUS_FLG_NODUMP)
 		flags |= FS_NODUMP_FL;
+	if (test_bit(HFSPLUS_SB_CASEFOLD, &sbi->flags))
+		flags |= FS_CASEFOLD_FL;
 
 	fileattr_fill_flags(fa, flags);
 
@@ -759,13 +762,24 @@ int hfsplus_fileattr_set(struct mnt_idmap *idmap,
 {
 	struct inode *inode = d_inode(dentry);
 	struct hfsplus_inode_info *hip = HFSPLUS_I(inode);
+	struct hfsplus_sb_info *sbi = HFSPLUS_SB(inode->i_sb);
+	unsigned int allowed = FS_IMMUTABLE_FL | FS_APPEND_FL | FS_NODUMP_FL;
 	unsigned int new_fl = 0;
 
 	if (fileattr_has_fsx(fa))
 		return -EOPNOTSUPP;
 
+	/*
+	 * FS_CASEFOLD_FL reflects HFSPLUS_SB_CASEFOLD, a mount-time
+	 * property. Accept it as a no-op so chattr's RMW round-trip
+	 * succeeds; reject any attempt to enable it on a volume that
+	 * was not formatted case-insensitive.
+	 */
+	if (test_bit(HFSPLUS_SB_CASEFOLD, &sbi->flags))
+		allowed |= FS_CASEFOLD_FL;
+
 	/* don't silently ignore unsupported ext2 flags */
-	if (fa->flags & ~(FS_IMMUTABLE_FL|FS_APPEND_FL|FS_NODUMP_FL))
+	if (fa->flags & ~allowed)
 		return -EOPNOTSUPP;
 
 	if (fa->flags & FS_IMMUTABLE_FL)

-- 
2.53.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
