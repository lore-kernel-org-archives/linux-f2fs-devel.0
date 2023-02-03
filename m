Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32F26C64EC6
	for <linux-f2fs-devel@archiver.kernel.org>; Fri,  3 Feb 2023 21:01:16 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1pO3BM-0007Vg-AI;
	Fri, 03 Feb 2023 21:01:15 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <krisman@suse.de>) id 1pO3BJ-0007VP-AL
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 03 Feb 2023 21:01:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=6JM0S233H5Zlg+wbmnMEORelYFxm/eYxtlgCAFxYHpM=; b=BcSUXSaBy3+hB2y7G3nzWIxQ9c
 4QM7bFzvABDyI9TQHxN+DybLxb+Ma/81VmI/w4hv6CFEtg+6e+GK2LfAVu1gz5i9PNwaYRZ2LQXl7
 PrhdEEawh5IlyfjHni8CWfjkDTYdfPTWDFkM8JL3Cl5kIfoBSkc1ospPL4w2so85Jtrk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=6JM0S233H5Zlg+wbmnMEORelYFxm/eYxtlgCAFxYHpM=; b=WjM9N0ASCvII4XobCx8S07MP+Y
 jQ1BLpzRRM9p+sysY819KZjzDZjcZ3EllO0qur1RqA4/sR0fmfZCYFPO+ek6RPcnafzrtPsPSigGz
 lukT72TGOMrq/UEDuMpYyBvkRi5GsY3RlQNa97sVSTcx1v7pF5uQdKGxYMNAzve+2uvQ=;
Received: from smtp-out1.suse.de ([195.135.220.28])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1pO3BE-00ASxB-LS for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 03 Feb 2023 21:01:12 +0000
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6EF8C35225;
 Fri,  3 Feb 2023 21:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1675458062; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6JM0S233H5Zlg+wbmnMEORelYFxm/eYxtlgCAFxYHpM=;
 b=RHBSf8tLDD1qBfHRuD5rEr0W2FiKZdvW+VnDQ29rOp4EjA8voyuaMvtYJh1+dC5IT3+94h
 mWQvBZJu01NC3tP59ne1o0xlyHiuvbPdVGa3Om/VKcJaO3MotAyz749wBFcDa3Ztdv3MPK
 gH+mnmB/N3MqoxPkg1hlBlNdwC588EY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1675458062;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6JM0S233H5Zlg+wbmnMEORelYFxm/eYxtlgCAFxYHpM=;
 b=cr13Y4pJqQk1Kw2d0p6MK1SswSuP8zEd5IT0QTqz8HrLGvHs5neX+lpbjOC43QhX4Mq4B0
 A7L1EQ1xxAg58BBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F3BAE1358A;
 Fri,  3 Feb 2023 21:01:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id T3HWLg123WPyJgAAMHmgww
 (envelope-from <krisman@suse.de>); Fri, 03 Feb 2023 21:01:01 +0000
From: Gabriel Krisman Bertazi <krisman@suse.de>
To: viro@zeniv.linux.org.uk, tytso@mit.edu, jaegeuk@kernel.org,
 ebiggers@kernel.org, jack@suse.cz
Date: Fri,  3 Feb 2023 18:00:35 -0300
Message-Id: <20230203210039.16289-4-krisman@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230203210039.16289-1-krisman@suse.de>
References: <20230203210039.16289-1-krisman@suse.de>
MIME-Version: 1.0
X-Headers-End: 1pO3BE-00ASxB-LS
Subject: [f2fs-dev] [PATCH v2 3/7] libfs: Validate negative dentries in
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
Cc: linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
 Gabriel Krisman Bertazi <krisman@collabora.com>,
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

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
---
 fs/libfs.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/fs/libfs.c b/fs/libfs.c
index aada4e7c8713..e3daca88d1d3 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -1467,9 +1467,33 @@ static int generic_ci_d_hash(const struct dentry *dentry, struct qstr *str)
 	return 0;
 }
 
+static inline int generic_ci_d_revalidate(struct dentry *dentry,
+					  const struct qstr *name,
+					  unsigned int flags)
+{
+	int is_creation = flags & (LOOKUP_CREATE | LOOKUP_RENAME_TARGET);
+
+	if (d_is_negative(dentry)) {
+		const struct dentry *parent = READ_ONCE(dentry->d_parent);
+		const struct inode *dir = READ_ONCE(parent->d_inode);
+
+		if (dir && needs_casefold(dir)) {
+			if (!d_is_casefold_lookup(dentry))
+				return 0;
+
+			if (is_creation &&
+			    (dentry->d_name.len != name->len ||
+			     memcmp(dentry->d_name.name, name->name, name->len)))
+				return 0;
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
2.35.3



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
