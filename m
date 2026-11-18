Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 564E9606A31C
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 18 Nov 2026 00:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=lNyO5IsW;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=fKAoXcZX;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=JtSc15+h;
	dkim=neutral header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DjUc1tFl
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=H8dqMKVX8FGU+plCrq3CdtED6RNrGnJ0mlNnq8V+5cY=; b=lNyO5IsWwb5YOOL3WJanfIZcRx
	1myMMiq4guJ50J7PjKXSy8E6+yNYEnv1M8cgKACXxHtk05efXhBDAiKE0/dpHFlDR/e68ADO+RdPS
	nQ/+lOTMGF9JSUtuieizytuotftbAqxoZXUa1kEMOyKuq+S12WkiNL0kG4k8vk6CH+ck=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xTTYa-000000004Nq-0I5p;
	Wed, 18 Nov 2026 00:29:48 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <blum@kernel.org>) id 1xTTYY-000000004NW-13At
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 18 Nov 2026 00:29:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=77Zc1u0jfwO76KAyX4WCIbvGbPpwLYaW9Jlo2sPynfo=; b=fKAoXcZXVv+bDaR/LGnNnV9tzy
 onos4NxWOZvnKKzipwVemKQ6bs/9O8QkHidpN1GixXn87nEp6EE2mbq2YCuAVPCcqtbtczWa/EvHB
 7JfwGq7g5ZcEzcyvLaXZjCVMy5cZkLm8xfNa7uo43XdnWdgx9yxieN4gOR0IDupoOkbU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=77Zc1u0jfwO76KAyX4WCIbvGbPpwLYaW9Jlo2sPynfo=; b=JtSc15+hp9qav0MGca9hCNRx59
 MmXSlq1ahilu30LZ3Sy4eKIJYfAeMibBdgIPBo7dZ5rvu1P5OS5zK12fYBaPr/SuKOrtpvgqUKzXS
 v2XlrTnQqoiQ21nIGqPg5h+ItND999zU5rm5q8IUQaA0gH4+/a/snpt+rkgE2+0rnZPM=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xTTYX-000000005hj-2u0L
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 18 Nov 2026 00:29:46 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4EC4B43B61;
 Wed, 18 Nov 2026 00:29:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 022E21F000C5;
 Wed, 18 Nov 2026 00:29:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794961780;
 bh=77Zc1u0jfwO76KAyX4WCIbvGbPpwLYaW9Jlo2sPynfo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=DjUc1tFlOzVBzrYcXaPjCSi6i0uyhGfvMjsCTw9wPfX9BGKuTOeFjr1b832Vu99cL
 jp1BV4nyinAEqqimy7fZ3LpEC9U9HrsuiZl4zXdDGhZEjU0pGYEuMeRxZzztktpi6q
 bX+6Q1ORLsoxks9UnBx0uFWziaMGC8KVjKvEh/3U//qqUxdJBQZhUmmRmluFUXOvHQ
 HFn1FgAgCYF4mRr7ugb3wKX4DI05/Fz90qvN+m30J68S4EgLui8QMRKNDQUhwn6QZK
 J6gm4FTPnDAc81JqjeSjs68y2lDw0blFNZmXCX3DGNY+89wnlJhoAjg4q0cpCqxpc2
 YyLnYFIi6dOUQ==
To: David Sterba <dsterba@suse.com>, Chris Mason <mason@kernel.org>,
 Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
 Richard Weinberger <richard@nod.at>,
 Zhihao Cheng <chengzhihao1@huawei.com>, Eric Biggers <ebiggers@kernel.org>,
 "Theodore Y. Ts'o" <tytso@mit.edu>
Date: Wed, 18 Nov 2026 01:28:47 +0100
Message-ID: <20261118002845.574426-7-blum@kernel.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261118002845.574426-6-blum@kernel.org>
References: <20261118002845.574426-6-blum@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=730; i=blum@kernel.org;
 h=from:subject; bh=9TS87tFQrJmJ2L6d5vREcb1e62JHLVxiiKSkN7PY/9U=;
 b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFl/Ptq5/b51/ZGu2+FIucCFP+qZ/J50hR/m2B2qoMu2f
 p3ujtL9HaUsDGJcDLJiiiwPZv2Y4VtaU7nJJGInzBxWJpAhDFycAjARFRGG/4msy3fns51NOsx7
 JpD/+k3J0ki2ju+qS+9b8detfVXCacXwV+7Ggvu/J2UIOnB823+jQsTzhqtj3f5yNef1Fs+E9l5
 34gQA
X-Developer-Key: i=blum@kernel.org; a=openpgp;
 fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xTTYX-000000005hj-2u0L
Subject: [f2fs-dev] [PATCH 1/4] fscrypt: Add FSTR() helper macro
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

Similar to QSTR(), add FSTR() to initialize struct fscrypt_str from a
NUL-terminated string without specifying its length.

Signed-off-by: Thorsten Blum <blum@kernel.org>
---
 include/linux/fscrypt.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/fscrypt.h b/include/linux/fscrypt.h
index 28f2108e29f3..84d9147fda2f 100644
--- a/include/linux/fscrypt.h
+++ b/include/linux/fscrypt.h
@@ -50,6 +50,7 @@ struct fscrypt_name {
 };
 
 #define FSTR_INIT(n, l)		{ .name = n, .len = l }
+#define FSTR(n)			((struct fscrypt_str)FSTR_INIT(n, strlen(n)))
 #define FSTR_TO_QSTR(f)		QSTR_INIT((f)->name, (f)->len)
 #define fname_name(p)		((p)->disk_name.name)
 #define fname_len(p)		((p)->disk_name.len)


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
