Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97CF3CD98E4
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 17 Jun 2026 11:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AIuh3s76Keigdm6dW0VNBMnx7FvOY7wtsVnljajldcg=; b=TgsYKOBab4XJksJJFpyGlnLE9w
	LuaHijyR222uYK4BNKPu1rr07kdrWJYvsPASMNHOtB3slQlSrd4pt1FarPG3VCK1Xhuc3z8jj7rui
	BSZU+ty+jLnILncT6gzLc/tkdx1hIInMH0bdFzJX8cusPG5IJBSK0yrnl6Cf4/Gp8ApA=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wZoKS-0008Dy-62;
	Wed, 17 Jun 2026 11:21:08 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <asj@kernel.org>) id 1wZoKQ-0008Dl-Ug
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 17 Jun 2026 11:21:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=t44VYnkqYUcNne6L8i6KxniT652yq2VD+rASCJVNRN4=; b=mquohbajcRk1AfT1chcDhWCjtq
 DZTr0alXga1BwHSqewxSvchOUtK1hbEH6tIzTBun/uGhoV4/W5fCc2vo24iYbrHyiwJO5beYMSPwG
 mHDecejA0NSrDZEJgsg8sROTmlViGFF1uTU/470OAFxj3pAkqOcDzvh1QnaEVQfo3Ie4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=t44VYnkqYUcNne6L8i6KxniT652yq2VD+rASCJVNRN4=; b=QyAOWCP6ZXtghoqtyPnTVM9l+E
 VzLlQza94mUB/jmiNCd59GvIU6ZG6UyVMDmnx1X0d4dFkWE2L8yWT99X6L40BN+r1xljrPujTNren
 51FlryGkqPzfvRZ3a9wkDd66cDXnMw4YL9dPYMp1P/CeBUqzRIQeGbPCbCu4bgfnQ6F4=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wZoKO-0002NP-G6 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 17 Jun 2026 11:21:07 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6B06860137;
 Wed, 17 Jun 2026 11:20:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 121F31F00A3A;
 Wed, 17 Jun 2026 11:20:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781695259;
 bh=t44VYnkqYUcNne6L8i6KxniT652yq2VD+rASCJVNRN4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=U8Mj6K11sKGneKpuvwkdoFpeKVOYKDrMMNCV3dgXgBP4Xus8Y/+ThPr9sb2WhuDph
 h5c6WfbuSqMmZj/DHVCu1j0Kzow0vUK8j9rJX5BNm2rygH5q9MPIGJWAsIs4b0F2g2
 Vnr9wv0wOoVfmHW3LNxnEFmEXw3tJ3uoPzVA8fPmMg1+BZevKh2FgcDn2bsfASGNAU
 XvsnTTroUr98HXLbYs9egxgdrpGifExPLlPz8+sa49dXwhqnKe9OwhO75cFUQ0yYBb
 wKKGbxQN1wGireUOIXDH8EPKcxIFn/koxtY6MaboyIwsnv/Ejv1GBx3vDEEcCMykYL
 7mqopCQ9BdWzA==
To: fstests@vger.kernel.org
Date: Wed, 17 Jun 2026 19:20:31 +0800
Message-ID: <f556db45f1ffc93508a69ce9f9e567b74384210f.1781694879.git.asj@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1781694879.git.asj@kernel.org>
References: <cover.1781694879.git.asj@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1wZoKO-0002NP-G6
Subject: [f2fs-dev] [PATCH v7 04/11] fstests: add _require_unique_f_fsid()
 helper
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
From: Anand Jain via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Anand Jain <asj@kernel.org>
Cc: hch@infradead.org, djwong@kernel.org, zlang@redhat.com,
 linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
 linux-ext4@vger.kernel.org, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Add a helper to check if the target filesystem supports unique f_fsid
tracking across cloned or snapshot instances.

Certain filesystems like XFS, Btrfs, and F2FS ensure unique f_fsid
identifiers per filesystem instance. However, Ext4 derives its f_fsid
directly from its superblock UUID, which leads to identical f_fsid
values on cloned images until the UUID is manually modified by userspace.

Introduce _require_unique_f_fsid() to allow test cases requiring strict
f_fsid uniqueness to skip gracefully on unsupported filesystems.

Signed-off-by: Anand Jain <asj@kernel.org>
---
 common/rc | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/common/rc b/common/rc
index 968ba33686f3..d95eec94f7b7 100644
--- a/common/rc
+++ b/common/rc
@@ -6310,6 +6310,27 @@ _require_fanotify_ioerrors()
 	_notrun "$FSTYP does not support fanotify ioerrors"
 }
 
+# Ext4 derives f_fsid from the superblock UUID, meaning clones share the
+# same f_fsid until their UUIDs diverge. Conversely, XFS, Btrfs,
+# and F2FS ensure f_fsid remains unique per filesystem instance (often by
+# deriving it from the UUID and underlying block device.)
+#
+# Across all filesystems, a UUID collision causes libblkid tools to return
+# non-deterministic device mappings. It is ultimately the responsibility
+# of the userspace utility or use-case to enforce uniqueness when a clone
+# diverges. For details, see mailing list thread discussions:
+#   Link: https://lore.kernel.org/linux-ext4/20260409131238.GC18443@macsyma-wired.lan/
+_require_unique_f_fsid()
+{
+	# Skip the test if the filesystem does not enforce unique f_fsids
+	# natively. Checking this dynamically requires recreating a clone
+	# layout, so we use a static lookup based on FSTYP.
+	if [ "$FSTYP" == "ext4" ]; then
+		_notrun "Target filesystem ($FSTYP) does not guarantee unique f_fsid on clones."
+	fi
+}
+
+
 # Computes a percentage of the available space in a filesystem and
 # returns that quantity in MB. The percentage must not contain a percent
 # sign ("%").
-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
