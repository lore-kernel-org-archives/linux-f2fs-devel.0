Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D6B8C001E0
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 19 Jul 2023 22:19:46 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1qMFWL-0006pN-4F;
	Wed, 19 Jul 2023 22:19:44 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <krisman@suse.de>) id 1qMFWJ-0006pE-F7
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 19 Jul 2023 22:19:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=M4N/dCF5EYbxPk5QcgdReto7C0f6ZT5aB5kgR17CLu8=; b=VeCEK7yO3rVYbHfvei2Ip6gtT1
 KboaHX/dBmHvMx92CngB8ZdM2MqQbTllXft6cmMMtMNgHidexfNFrq+EKIoexa/FqfCkacquhNkxm
 1wRjVB41Iffhv/xPCn2W4Hq/6112DFlGhoUkda/boD+G+2MDKSbGspsnb5v97311H6Dw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=M4N/dCF5EYbxPk5QcgdReto7C0f6ZT5aB5kgR17CLu8=; b=KPRYGBsyxgHU1dnPtCuD2aMYMG
 oWF6fsE7r94zy3omjSVjnUlClhsfCM3MOzKLJ56oljazXhOMaar8BQUQKeQ+3Vn1dnc9+dDjn01m5
 vlZtBgSTtqrWRUQdl/GQ1Ps2kRMNZ+iEivofEG2fFiBmyAaOrdVAc9N7Q1eaVyDZLrM0=;
Received: from smtp-out1.suse.de ([195.135.220.28])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1qMFWH-00DW3D-Ae for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 19 Jul 2023 22:19:42 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D01AB222D8;
 Wed, 19 Jul 2023 22:19:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1689805174; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M4N/dCF5EYbxPk5QcgdReto7C0f6ZT5aB5kgR17CLu8=;
 b=Zy03tGDv7kKXMm6ixKTC494h49WMMpRuDWriMyVelM0GRihZfjG/mgzv10o/IslFmAgHdp
 p5tvg4SjPZzxvmWzAMmKjVdhQBwqKsmPw5j642Rv2zD+gF9X/QKBt88jK2NQhMQJKzFDYX
 OiQzj/GgvyNsbZBtJc+Exydd5c+zsjc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1689805174;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M4N/dCF5EYbxPk5QcgdReto7C0f6ZT5aB5kgR17CLu8=;
 b=YzTwAebjNAjddO7F5kVBuhXxCIDpmXueP9mpfiw4VB+XgPWtn2Le53QpbZ3idNPkadymBq
 agOuPkcUiFFZRrDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 989721361C;
 Wed, 19 Jul 2023 22:19:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id l/2bH3ZhuGQVJgAAMHmgww
 (envelope-from <krisman@suse.de>); Wed, 19 Jul 2023 22:19:34 +0000
From: Gabriel Krisman Bertazi <krisman@suse.de>
To: viro@zeniv.linux.org.uk, brauner@kernel.org, tytso@mit.edu,
 ebiggers@kernel.org, jaegeuk@kernel.org
Date: Wed, 19 Jul 2023 18:19:14 -0400
Message-ID: <20230719221918.8937-4-krisman@suse.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230719221918.8937-1-krisman@suse.de>
References: <20230719221918.8937-1-krisman@suse.de>
MIME-Version: 1.0
X-Headers-End: 1qMFWH-00DW3D-Ae
Subject: [f2fs-dev] [PATCH v3 3/7] libfs: Validate negative dentries in
 case-insensitive directories
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
Cc: linux-fsdevel@vger.kernel.org, Gabriel Krisman Bertazi <krisman@suse.de>,
 linux-ext4@vger.kernel.org, Gabriel Krisman Bertazi <krisman@collabora.com>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Gabriel Krisman Bertazi <krisman@collabora.com>

Introduce a dentry revalidation helper to be used by case-insensitive
filesystems to check if it is safe to reuse a negative dentry.

A negative dentry is safe to be reused on a case-insensitive lookup if
it was created during a case-insensitive lookup and this is not a lookup
that will instantiate a dentry. If this is a creation lookup, we also
need to make sure the name matches sensitively the name under lookup in
order to assure the name preserving semantics.

dentry->d_name is only checked by the case-insensitive d_revalidate hook
in the LOOKUP_CREATE/LOOKUP_RENAME_TARGET case since, for these cases,
d_revalidate is always called with the parent inode locked, and
therefore the name cannot change from under us.

d_revalidate is only called in 4 places: lookup_dcache, __lookup_slow,
lookup_open and lookup_fast:

  - lookup_dcache always calls it with zeroed flags, with the exception
  of when coming from __lookup_hash, which needs the parent locked
  already, for instance in the open/creation path, which is locked in
  open_last_lookups.

  - In __lookup_slow, either the parent inode is locked by the
  caller (lookup_slow), or it is called with no
  flags (lookup_one/lookup_one_len).

  - lookup_open also requires the parent to be locked in the creation
  case, which is done in open_last_lookups.

  - lookup_fast will indeed be called with the parent unlocked, but it
  shouldn't be called with LOOKUP_CREATE.  Either it is called in the
  link_path_walk, where nd->flags doesn't have LOOKUP_CREATE yet or in
  open_last_lookups. But, in this case, it also never has LOOKUP_CREATE,
  because it is only called on the !O_CREAT case, which means op->intent
  doesn't have LOOKUP_CREAT (set in build_open_flags only if O_CREAT is
  set).

Finally, for the LOOKUP_RENAME_TARGET, we are doing a rename, so the
parents inodes are also be locked.

Reviewed-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>

---
Changes since v2:
  - Add comments to all rejection cases (eric)
  - safeguard against filesystem creating dentries without LOOKUP flags
---
 fs/libfs.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/fs/libfs.c b/fs/libfs.c
index 5b851315eeed..dd213f446427 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -1462,9 +1462,57 @@ static int generic_ci_d_hash(const struct dentry *dentry, struct qstr *str)
 	return 0;
 }
 
+static inline int generic_ci_d_revalidate(struct dentry *dentry,
+					  const struct qstr *name,
+					  unsigned int flags)
+{
+	if (d_is_negative(dentry)) {
+		const struct dentry *parent = READ_ONCE(dentry->d_parent);
+		const struct inode *dir = READ_ONCE(parent->d_inode);
+
+		if (dir && needs_casefold(dir)) {
+			/*
+			 * Filesystems will call into d_revalidate without
+			 * setting LOOKUP_ flags even for file creation(see
+			 * lookup_one* variants).  Reject negative dentries in
+			 * this case, since we can't know for sure it won't be
+			 * used for creation.
+			 */
+			if (!flags)
+				return 0;
+
+			/*
+			 * Negative dentries created prior to turning the
+			 * directory case-insensitive cannot be trusted, since
+			 * they don't ensure any possible case version of the
+			 * filename doesn't exist.
+			 */
+			if (!d_is_casefold_lookup(dentry))
+				return 0;
+
+			if (flags & (LOOKUP_CREATE | LOOKUP_RENAME_TARGET)) {
+				/*
+				 * ->d_name won't change from under us in the
+				 * creation path only, since d_revalidate during
+				 * creation and renames is always called with
+				 * the parent inode locked.  It isn't the case
+				 * for all lookup callpaths, so ->d_name must
+				 * not be touched outside
+				 * (LOOKUP_CREATE|LOOKUP_RENAME_TARGET) context.
+				 */
+				if (dentry->d_name.len != name->len ||
+				    memcmp(dentry->d_name.name, name->name, name->len))
+					return 0;
+			}
+		}
+	}
+	return 1;
+}
+
 static const struct dentry_operations generic_ci_dentry_ops = {
 	.d_hash = generic_ci_d_hash,
 	.d_compare = generic_ci_d_compare,
+	.d_revalidate_name = generic_ci_d_revalidate,
 };
 #endif
 
-- 
2.41.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
