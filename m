Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86926606A33D
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 20 Nov 2026 15:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=b5pyZegi;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=fSlG1MR7;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=VUSn6nJB;
	dkim=neutral header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OZdZos0i
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=YRTWtOGs3l/XCMMS4bZViC5iF79qiNH7pkIU1UhvcHI=; b=b5pyZegiWMzHt15pu9gyfo0nYO
	E1Ew1XttZn7Igj8MIbKeGFvynzXQsC4Z45r74KXSjqu8uDT1AC328xTI4VVTyuowureb+HkOhzxtT
	GCksSlTW6vCfaQ4yMRDRFFhU33cAx+9DJ51vCCvU/pEEmA6G7OXt/9pLv2xorOqdpUqU=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xUQw2-000000004CC-15tA;
	Fri, 20 Nov 2026 15:53:58 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <aalbersh@kernel.org>) id 1xUQw1-000000004C6-0v7H
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 20 Nov 2026 15:53:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=E5gSXNwtA5kQIUw/uoqqaybdSZDyhnTy+gYKDJ9u12s=; b=fSlG1MR7Cq1W7g+GCShyypbRgk
 lNjAmFVtdfWvnM7ygoZoHQZmZkBpU9xoR9PkA2HS9+seZ3w7J/wnQj1PUdrNsDz6WyOFmjb/urW3+
 rx9b2FSfyXKACLvcnWgycarXR6IamVpsBcVl/n1Y46wv7Idl4PL9y/aVGlx8RcGHBCjI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=E5gSXNwtA5kQIUw/uoqqaybdSZDyhnTy+gYKDJ9u12s=; b=VUSn6nJBXmDDqVxh09Pc1Mz44e
 6TruN3Wv1D8o8SxeN13fbAqdb6BEb7xKxwqtpQLqdlUKRPHuxkt3rQYc3GusENsC9WOmePKyFjoaX
 wIamVL+/7HYFZC5SQ7baXsvH5vy3C62kP9JE9gpgUzuDn8rfxQlqCwB5plQ3VGlcm5so=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xUQw0-0000000023K-2Cz4
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 20 Nov 2026 15:53:57 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3C3FD469FE;
 Fri, 20 Nov 2026 15:53:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 991DB1F000C0;
 Fri, 20 Nov 2026 15:53:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795190031;
 bh=E5gSXNwtA5kQIUw/uoqqaybdSZDyhnTy+gYKDJ9u12s=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=OZdZos0iO9L6qP1cpJU5weQvoMm3GHHjbXInIphUY28MGhkG3q2du8yD1xctmgmGH
 gbt5/zngGoW28ArrsGoS5dH08PXLMsK9lDXGaagnSQ4md9kSA5Bb/AILT1ycq4YnED
 LuCGIqLwqkUtQuvMURjrahA5GCFlOodAjsxyCa5A6qrAzx5WM20BmRCGS02h6RpWuA
 qR0TgLvJ3tyiP1vP9Jc2EVhb7AMmvLJIHj1L7MupZbXQsL2OrPRmydy6SRJBoRHF4u
 TIg/XFB1MetA6nLlgzGlBgJsFmuMtHquozmk6XV7WQU1seCdlRciBDnscGTQY6evN8
 Bi2lWhQPS3Vcw==
To: "fsdevel" <linux-fsdevel@vger.kernel.org>,
 "fsverity" <fsverity@lists.linux.dev>,
 "linux-ext4" <linux-ext4@vger.kernel.org>,
 "linux-btrfs" <linux-btrfs@vger.kernel.org>,
 "linux-f2fs" <linux-f2fs-devel@lists.sourceforge.net>,
 "linux-xfs" <linux-xfs@vger.kernel.org>, dsterba@suse.com,
 "Eric Biggers" <ebiggers@kernel.org>,
 "Christian Brauner" <brauner@kernel.org>
Date: Fri, 20 Nov 2026 16:50:23 +0100
Message-ID: <20261120155032.187246-2-aalbersh@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261120155032.187246-1-aalbersh@kernel.org>
References: <20261120155032.187246-1-aalbersh@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xUQw0-0000000023K-2Cz4
Subject: [f2fs-dev] [PATCH v3 1/7] fs: constify inode argument of
 inode_state_read_once()
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
From: Andrey Albershteyn via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Andrey Albershteyn <aalbersh@kernel.org>
Cc: tytso@mit.edu, Andrey Albershteyn <aalbersh@kernel.org>,
 viro@zeniv.linux.org.uk, jaegeuk@kernel.org, Jan Kara <jack@suse.cz>,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Constify inode parameter so that callers can pass const inode. Callers
do not need a change.

Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/fs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 5b3a100aba77..5c62a968fbde 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -878,7 +878,7 @@ struct inode {
  *
  * We hide all of it behind helpers so that we can validate consumers.
  */
-static inline enum inode_state_flags_enum inode_state_read_once(struct inode *inode)
+static inline enum inode_state_flags_enum inode_state_read_once(const struct inode *inode)
 {
 	return READ_ONCE(inode->i_state.__state);
 }
-- 
2.54.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
