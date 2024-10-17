Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53662D3C536
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 17 Oct 2024 22:05:52 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1t1Ycw-0005cV-Va;
	Thu, 17 Oct 2024 22:05:50 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <thorsten.blum@linux.dev>) id 1t1Ycv-0005cP-Kz
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 17 Oct 2024 22:05:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=KLtHY9tS67dDZxAwj9pQlA2Bn0F9rB4pbPk7zyiMrFE=; b=gs2+9ThAxmkKoc7w+lk5MR8kc+
 tEhX+aFETtdeBxQCOAytp3CRRk6zNJNagO0cs/ZJ3r5XiKBn/0fP8Rk8mwuBfUufEx+dd5W2I29zK
 cAP+R4bjqiSlOpDaS/20chzHunzIKIRn2jSZ1G7Ugp8gOQT278A/+YPMHZ7Amca0/VnE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=KLtHY9tS67dDZxAwj9pQlA2Bn0F9rB4pbPk7zyiMrFE=; b=d
 QQ3O7FAUTNDtXsrcPjtrvzVV6P5KQ/HCn3qy0/5ABkbuDI0BN8uDvphEK+q56w25lyM1Z60lSqwyx
 4AYRQQHrccBx6BHgDnEGdN7c38zIPx6Fxb8lwmErem5E91hCFZuJU2prtLyjV+Kxs328sB0f9gk/k
 TdBo2j2c0zMAS9RI=;
Received: from out-170.mta1.migadu.com ([95.215.58.170])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1t1Yct-0003AO-Su for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 17 Oct 2024 22:05:49 +0000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1729202736;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=KLtHY9tS67dDZxAwj9pQlA2Bn0F9rB4pbPk7zyiMrFE=;
 b=rrZR6XW5obyGjfp9maIjt+NwAWzo0Ut3OPAfuViOukBWE15y1qHD/960MHE3i5uep9nzyy
 roFl0uJIIvX/G7kLKIwRUKF2ngJG8mWLbO5jpwxxKQ/Mxj7NAdyT1ORKj2x/CmEMgg2opV
 xb2J5Yhc6+bgMYYPeRR1BVwhiUuIzZs=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>
Date: Fri, 18 Oct 2024 00:05:03 +0200
Message-ID: <20241017220502.1592-2-thorsten.blum@linux.dev>
MIME-Version: 1.0
X-Migadu-Flow: FLOW_OUT
X-Headers-End: 1t1Yct-0003AO-Su
Subject: [f2fs-dev] [RESEND PATCH] f2fs: Use struct_size() to improve
 f2fs_acl_clone()
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
Cc: linux-kernel@vger.kernel.org, Thorsten Blum <thorsten.blum@linux.dev>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Use struct_size() to calculate the number of bytes to allocate for a
cloned acl.

Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 fs/f2fs/acl.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/acl.c b/fs/f2fs/acl.c
index 8bffdeccdbc3..1fbc0607363b 100644
--- a/fs/f2fs/acl.c
+++ b/fs/f2fs/acl.c
@@ -296,9 +296,8 @@ static struct posix_acl *f2fs_acl_clone(const struct posix_acl *acl,
 	struct posix_acl *clone = NULL;
 
 	if (acl) {
-		int size = sizeof(struct posix_acl) + acl->a_count *
-				sizeof(struct posix_acl_entry);
-		clone = kmemdup(acl, size, flags);
+		clone = kmemdup(acl, struct_size(acl, a_entries, acl->a_count),
+				flags);
 		if (clone)
 			refcount_set(&clone->a_refcount, 1);
 	}
-- 
2.47.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
