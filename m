Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86D4DC982C9
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 16 Jan 2026 14:46:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UMU80MXxJCgfAMddneFmFpKc5hpF2G4uv90LYNliSHs=; b=igs2T8r4kEiLm5N8Mp8kOIt/x3
	LpBJhPjpas9eDOTyevh28NuqFaSWPTg9wVGuxtBthZkG2xS75YaPJ/B6Ko34rgFFIbLrHevmJZsXz
	RvU8Kv1rc6YnvdFZJxoYD6rmOybYevwZRApQQqAbxLd2ZfEgKYUJEjCERrEZ9uadlLLU=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1vgl66-0001t8-Do;
	Fri, 16 Jan 2026 14:46:47 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <cel@kernel.org>) id 1vgl65-0001su-G8
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 16 Jan 2026 14:46:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=qhOV7iQINfiUBGxoscNk6HEdAGMqddAbchXOBtHBaWg=; b=Uwj0qr+Mf+9RY1zUH7TfQhRWjL
 ssJyvTOZvVpS1DKYMd9DMPazDzVxRQKp48VKIzR2WMPVoVKE+1sNeMaX9Q04zANRUCuvxBm6slYLT
 pdJzU2r4YbFBBtA9P7OM6oumgH2GY3oH4Rknzc4rOJF96Ogfa1UnRPdFPwxCrDZDDooA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=qhOV7iQINfiUBGxoscNk6HEdAGMqddAbchXOBtHBaWg=; b=jEQorqmAecIaw+CoJbzdyjRjKO
 6MUv+7sVgW/rY8tXlRUM3Eb2PC8eUNZQ9E7R8ulO/3zJiWPrzl68xEVyFnnstpWOf4cY7KH1F2a+b
 Tjo6FrCIy9952n+9/jnzAopHJCVBE0ZlhXZUzbXPa63hl3d7jXFfffnG1fXc/03mh9rE=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1vgl65-0002E9-Je for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 16 Jan 2026 14:46:46 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 490A843C88;
 Fri, 16 Jan 2026 14:46:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F32EAC116C6;
 Fri, 16 Jan 2026 14:46:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1768574795;
 bh=7L4KjJ52/tlODNs/DbrL8VR4WdJ76Ryp9p91k5Grblo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=IsRpk/C5WD128bHCrTDAhbUJQHUMOR6eVKWJDhnsz1Uv5beLQM3FFeh9k8PdEnD+j
 9wkg5vOie2GpG9SwdMIqGagbMurKpoD8C8yjZqBuyEegRU3+50+4EwARqaL+HPzl/G
 SdP9JhfYjMmLbsOrZbTDckXkW0qrHRpF33eLdEeXN7MXarBU9rpAFDsqhZkxQCC+Y1
 zjMRi3Gd1j9f+ryX7g/BLJ5d14gHeCUaQAP2BMnMKovbUSHteNzQLtwOkR5RY7fUji
 vGmJnMw/tPsALbSeWXeSXBCnUK/femVtMhjz0TB9iHJiwAgdTo60WcJFN82FGQlmxa
 kgPSdp6q6EVoQ==
To: Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>,
 Jan Kara <jack@suse.cz>
Date: Fri, 16 Jan 2026 09:46:05 -0500
Message-ID: <20260116144616.2098618-7-cel@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260116144616.2098618-1-cel@kernel.org>
References: <20260116144616.2098618-1-cel@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1vgl65-0002E9-Je
Subject: [f2fs-dev] [PATCH v5 06/16] hfsplus: Report case sensitivity in
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
 almaz.alexandrovich@paragon-software.com, adilger.kernel@dilger.ca,
 linux-cifs@vger.kernel.org, sfrench@samba.org, slava@dubeyko.com,
 linux-ext4@vger.kernel.org, linkinjeon@kernel.org, sprasad@microsoft.com,
 frank.li@vivo.com, ronniesahlberg@gmail.com, glaubitz@physik.fu-berlin.de,
 jaegeuk@kernel.org, hirofumi@mail.parknet.co.jp, linux-nfs@vger.kernel.org,
 tytso@mit.edu, linux-f2fs-devel@lists.sourceforge.net,
 linux-xfs@vger.kernel.org, senozhatsky@chromium.org,
 Chuck Lever <chuck.lever@oracle.com>, hansg@kernel.org, anna@kernel.org,
 linux-fsdevel@vger.kernel.org, sj1557.seo@samsung.com, trondmy@kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Chuck Lever <chuck.lever@oracle.com>

Add case sensitivity reporting to the existing hfsplus_fileattr_get()
function. HFS+ always preserves case at rest.

Case sensitivity depends on how the volume was formatted: HFSX
volumes may be either case-sensitive or case-insensitive, indicated
by the HFSPLUS_SB_CASEFOLD superblock flag.

Reviewed-by: Viacheslav Dubeyko <slava@dubeyko.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/hfsplus/inode.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/hfsplus/inode.c b/fs/hfsplus/inode.c
index 7ae6745ca7ae..7889d37f5c85 100644
--- a/fs/hfsplus/inode.c
+++ b/fs/hfsplus/inode.c
@@ -694,6 +694,7 @@ int hfsplus_fileattr_get(struct dentry *dentry, struct file_kattr *fa)
 {
 	struct inode *inode = d_inode(dentry);
 	struct hfsplus_inode_info *hip = HFSPLUS_I(inode);
+	struct hfsplus_sb_info *sbi = HFSPLUS_SB(inode->i_sb);
 	unsigned int flags = 0;
 
 	if (inode->i_flags & S_IMMUTABLE)
@@ -705,6 +706,12 @@ int hfsplus_fileattr_get(struct dentry *dentry, struct file_kattr *fa)
 
 	fileattr_fill_flags(fa, flags);
 
+	/*
+	 * HFS+ preserves case (the default). Case sensitivity depends
+	 * on how the filesystem was formatted: HFSX volumes may be
+	 * either case-sensitive or case-insensitive.
+	 */
+	fa->case_insensitive = test_bit(HFSPLUS_SB_CASEFOLD, &sbi->flags);
 	return 0;
 }
 
-- 
2.52.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
