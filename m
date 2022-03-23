Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 496C4C433F5
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 23 Mar 2022 02:29:19 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1nWqkQ-0000uh-4f; Wed, 23 Mar 2022 02:29:16 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <jaegeuk@kernel.org>) id 1nWqkP-0000ub-5P
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 23 Mar 2022 02:29:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=PdwMHetARsqX+v1+S4LhhJlZavGp2ROUH1NlqUspIkI=; b=U//jDj4Hyrev3EuzBG7b0CcszH
 p3NlZwGGhK3bpJZ+zXUjLVS7lyr5vQJG6n8hBnLnZrHsj+fQApnk0ElKibg10qrmqAuZK7YslzTuo
 IoY+ZL9qjaQnOtX/Jyjj+r04D7yGdLsaR5rGRXBc09pfLS9/rS4poMd45gQ20or+In4w=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=PdwMHetARsqX+v1+S4LhhJlZavGp2ROUH1NlqUspIkI=; b=D
 Obx0GxD1PRZo4mPmXgEyOoa2UJB9XEGt1/BsS0jpn61T6QLY0aOpQKc7bl6mwEc5bw6t2IZ6Fwo/D
 f+9NDQUMfPAmupbvqJuuplj5KYka+m8LmFjfi+N8xFSz74qkpk+ciIQJ8jaFc+UX2FFdmjnCa85qo
 7vlY3wN4V1KnwfBY=;
Received: from ams.source.kernel.org ([145.40.68.75])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.94.2)
 id 1nWqkJ-0007Xb-4x
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 23 Mar 2022 02:29:15 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id D5136B81DE2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 23 Mar 2022 02:29:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75350C340EC;
 Wed, 23 Mar 2022 02:29:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1648002543;
 bh=Qj271rEMUsl7ldDGNIzLQofXWikDc61nn9RVQ+rZ4yQ=;
 h=From:To:Cc:Subject:Date:From;
 b=fBmoonzj5pDmVtkZV0p5nhvLDue9Snx002kiliVa+KwmUBnI8u21+0YJTk7cHtUVJ
 JkkfDzCws449e7/PG/ri3e51Xau7wIzZgUCo+PNs7MZMqcoBBp0MXnrDzpf503Jfm4
 uRd+NlKJpzPzx28aM/zLYzYXSrpJRYkifkAdAzq8m2Xv0NCb1xK3xFuwSk3Z3jaxSl
 mG1teCY0hGJmL6zEeVUwY6Cq3ShdNmIKRej2I5SD12MhMfAGWnoAkXGBN2DVhTEJOQ
 1D3LIX3rTZbExR7QJdGd5PhZ0hRkQrrYNxO2UrfjKZ8RpDomH/atmynWLgOBw9dotS
 TjSg4/i8MKIKA==
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: linux-f2fs-devel@lists.sourceforge.net
Date: Tue, 22 Mar 2022 19:28:46 -0700
Message-Id: <20220323022846.1318136-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.35.1.894.gb6a874cedc-goog
MIME-Version: 1.0
X-Headers-End: 1nWqkJ-0007Xb-4x
Subject: [f2fs-dev] [PATCH] man: update mkfs.f2fs to give the default
 android option
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
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

This gives an information of "-g android".

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 man/mkfs.f2fs.8 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/man/mkfs.f2fs.8 b/man/mkfs.f2fs.8
index 15e0bd9c25e4..a6249f6ef6ed 100644
--- a/man/mkfs.f2fs.8
+++ b/man/mkfs.f2fs.8
@@ -143,7 +143,7 @@ The following values are supported:
 .RS 1.2i
 .TP 1.2i
 .B android
-Use default options for Android.
+Use default options for Android having "-d1 -f -w 4096 -R 0:0 -O encrypt -O project_quota,extra_attr,{quota} -O verity".
 .RE
 .TP
 .BI \-i
-- 
2.35.1.894.gb6a874cedc-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
