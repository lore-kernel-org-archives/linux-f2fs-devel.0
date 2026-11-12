Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A09E606A33A
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 12 Nov 2026 21:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=L0J2HRU6;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=IwOpo907;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=QA63qIdP;
	dkim=neutral header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ub4hrBoH
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:List-Owner;
	bh=JoSkbLTZ3tldGPKb8/VSnKpA4r08K5ucJvz929hCIQU=; b=L0J2HRU6s7BnbiSQhNBYr5QMLE
	VjMrlSE7SwP8ZjUwfuO5+wUB2nq7U4DDerntPVpML/sYLEtfqRclrBcQA4A7M1LjrOJ7PcFwyO1sm
	fEmEN1P4QYk+AHWufBP5Y4C2OZ5epdTTguIuWokqq+erqR3P/C12KNymA/vrh6af1WxQ=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xRca0-000000006BO-114D;
	Thu, 12 Nov 2026 21:43:36 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <dennylin0707@gmail.com>) id 1xRcZs-000000006Ae-2nDS
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 12 Nov 2026 21:43:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=D0q4/bumRjYNT1+Q9z7QLzpTICqzesgJk/uGL7R0qDI=; b=IwOpo907bF/st3oxeqJVEZL0AO
 CZDaJYFhkrCHr9ZKdLwiiveQCRMxj7gJxaF1mivejHL53jVocsPbESLD2ROPgCjiwuzSX6zz0PBfs
 LF1/NGD0tYuX+pSWlxyacv/S1z9705qPzVAK7bfKRMbadwywWTc2b2nHIbn0yVyTeqHw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=D0q4/bumRjYNT1+Q9z7QLzpTICqzesgJk/uGL7R0qDI=; b=QA63qIdPd8BSM2CpnE9RGlZODl
 tEV/yUSH74uFq+DAuXeSL7eON/PCTRBLuEnnESVxQvyiEiQJRUYdpQXdKImzwXmBcQM9U4zGlbo/s
 AD463s/KG2wqy46svZ9INSTye40oLgIV3c7IYefuVi7rQODa+JuUf1WvBvJA+z1WB+X8=;
Received: from mail-dy2-f5.google.com ([74.125.229.5])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xRcZr-000000005NO-3yJb
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 12 Nov 2026 21:43:28 +0000
Received: by mail-dy2-f5.google.com with SMTP id
 5a478bee46e88-36caa19b0ffso185740eec.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 12 Nov 2026 13:43:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794519802; x=1795124602; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=D0q4/bumRjYNT1+Q9z7QLzpTICqzesgJk/uGL7R0qDI=;
 b=ub4hrBoHJedLKEDs6gJ94n37FlA+bhuFhs0V8ynB2cKz2hP6RHy4xLtGq3f6RPn/4O
 LLQuyeeQmz9RChQCxAPz7VhZ9K+l8CN911JJDfRIIfG/Jou8NvP8XvZnTfRDAnyHxDXz
 /30HgqLe+SJyUo4lc0AYy0CCC8sgJcxTx22lLEW/w+DN+yZMFS+yw7eWbLXulIrNcNkU
 cvkYuFQIh3w+HT/YYKW4AgGePgUXlmEBefN9zAOa6S/YgDUyLo6pZlbCeW5pQgk5YWCk
 Oi5fiSTKf9GzondCo+9WZHkz3PVYDO4BrZCwhw1yLgMaBLxq0oY4yNI74epcuaPFFUJ9
 1+Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794519802; x=1795124602;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=D0q4/bumRjYNT1+Q9z7QLzpTICqzesgJk/uGL7R0qDI=;
 b=UXjxMCppbXmi6FwD7vXn3xogh5v0PZUH5YZUnKrqfqxOFy2Lth5K7KfAw1RJbu6igc
 MJmTskd75Z3InNL3i3d44Pu4CzFixY+N50yQparoWJjXispKafNnGFPkvdY6pTxEuZdC
 H0izkWLytjduDS1KjrhC1kEMf+HPKSAnTlmwM9ySCvXNWkSBwJrzP6JBVJmGu/nvrqkn
 sGLrDuAdrSPaKHvigwJUMpw3cipHx/rquJVHREemvcoHZBbfvZakEZ2oqYOXyM5QgpFC
 W4PfA5mCIl9iJvZbkZ/MSpM0cDITkhY1w7piekncAZDgWuJUYQopuQFU0g1xEK3ew/fc
 MVcw==
X-Forwarded-Encrypted: i=1;
 AL+hErG7MY+cygltfOOMebnOxlGE0pNuZQwpTh3Yd0uU7OemhK4dCIO4JR1OEsbvkcWEBWG+21uaMNsp/gV5FRqW+Aul@lists.sourceforge.net
X-Gm-Message-State: APuU4Z9Kl0okgdLiMnu7ebcwvdzc4gket8VIjaXvK9G/Gws6r7DxV7Qy
 akp1UQ7Mvtdhlhkw4g1QHpk/0jv/5DdKamTj8bePO7NCRu4cBL4mX/uS
X-Gm-Gg: AYBFou16nfj6eghXn5c6vFIm7HViCg8J47Xd4f1m9mAcPBZZrCgj71Pv2k8BnYBk6IS
 Q2zhEJbS6l4pgx+zVeDhrFGDqKMsFEzdpCs3+VF7tcK5EzIlKtMO+4Su86XtduRh1u6t/4e8vS8
 I5Yoc38+eOjROVlozvVuLXWRwhO8EVXofMMnp0EesNFpinUndjufdp2XaN99qNd/0m+7sch5mTw
 VFTrZBY9OdQ05nJvmTsvdfSPWmsM67ydw9w9SZ3EKbHZL5Ab2aElJgBkedYJwAA/rC6PQ6MB/67
 jV3rZvNQJPdGg6++95sJb7LfWOlMYSN21ophIAfy5hWAcy0BfY4yXvosI3HtJm/kpYUd/dqyQCk
 CNzzBpbnmn7B6kjswFHbJUHhhr03vd7ugtJN8fBaAa7J+1Sbhr4+7AxPGlWNcsgqEgKPwRUiNrk
 AuD6pcpVWc0AOvwoGGOwP4UPLHM2suUwTEWYiNDw8phRZgT8Aby3hQX44YceAjt00/yHsBj+GDO
 RxFucLPTY5yICP16G5huwD20/rR8dcNs1+CXebr4PA6ElXX8nYU8t1Zeb09BEHVvTUD8XffMv8J
 P1umBsJqV5CUVYEwQNaN5zlJRpbomtdRhAQzEW0J22flCYrUXi+IQ3XHfl0sOprL9OVaNnS4peA
 mqgNfzy7jR2vql+w3sWlXxASUV1W0iz2SOzxRTA==
X-Received: by 2002:a05:7300:cc82:b0:36c:9b35:5d46 with SMTP id
 5a478bee46e88-379681c811dmr418553eec.26.1794519802105; 
 Thu, 12 Nov 2026 13:43:22 -0800 (PST)
Received: from localhost.localdomain ([98.148.34.5])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-37956bad134sm1194466eec.27.2026.11.12.13.43.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 13:43:21 -0800 (PST)
From: Hungyu Lin <dennylin0707@gmail.com>
To: jaegeuk@kernel.org,
	chao@kernel.org
Date: Thu, 12 Nov 2026 21:43:03 +0000
Message-ID: <20261112214303.16198-5-dennylin0707@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261112214303.16198-1-dennylin0707@gmail.com>
References: <20261112214303.16198-1-dennylin0707@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 0.1 (/)
X-Headers-End: 1xRcZr-000000005NO-3yJb
Subject: [f2fs-dev] [PATCH v2 4/4] f2fs: require write permission for
 F2FS_IOC_IO_PRIO
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: linux-kernel@vger.kernel.org, dennylin0707@gmail.com, daehojeong@google.com,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

F2FS_IOC_IO_PRIO does not check who the caller is, so any user who can
open a file, even read-only, can set its write I/O priority hint.

Require write permission on the inode.

Fixes: 5f95c1812a65 ("f2fs: add ioctl to get IO priority hint")
Suggested-by: Chao Yu <chao@kernel.org>
Cc: stable@vger.kernel.org
Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
---
 fs/f2fs/file.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 9d09ce597f72..e25c7166c367 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -3985,6 +3985,9 @@ static int f2fs_ioc_io_prio(struct file *filp, unsigned long arg)
 	if (!S_ISREG(inode->i_mode) || level >= F2FS_IOPRIO_MAX)
 		return -EINVAL;
 
+	if (inode_permission(file_mnt_idmap(filp), inode, MAY_WRITE))
+		return -EACCES;
+
 	inode_lock(inode);
 	F2FS_I(inode)->ioprio_hint = level;
 	inode_unlock(inode);
-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
