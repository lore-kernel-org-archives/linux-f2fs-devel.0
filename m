Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB382CD4F54
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 28 May 2026 21:20:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=l9LQqfN6B3Si9sHT3NZJ2YW7KBS2Vl5gFxcGwZVkBe0=; b=F7Dyg/hNqAR0jkJSS6svQJtzdw
	BUQ1s0V64shEszszttWL4Q578nuHBIg9n8ZEmdtiEX0v4kR7DgeAFONB+gii53ghA2nxIY5+z5+px
	oHOoLtqdLYUIyKeH9Jgz2UbqeKeIf66NcYGpeqqINc3PWNlU6FIB/ZLjFxWwNVtMI3Ss=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wSi9v-00005a-7a;
	Thu, 28 May 2026 21:20:56 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <bvanassche@acm.org>) id 1wSi9u-00005B-5a
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 28 May 2026 21:20:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=I12j25VCYwg/eP7OFqKC7AWmW1SqWD4Hv21aKHsbeYc=; b=YUWWjfOKECYOdfP+LdxMBkiYtj
 daCUcBue5P+Wt++mbXVeeDynhpaEbrPEk2yVqo3ogBwTiWLMbY5a9ChSGVEqca47D78EVSSZktck9
 OyNu6DQF65yNvcPKp/OPS0IaoiJM7ey7Fu72Xua8Yqt5Li952bSb6rS7YefYZztRUThk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=I12j25VCYwg/eP7OFqKC7AWmW1SqWD4Hv21aKHsbeYc=; b=XqR0Uf74QmugCGxkPTr/xB+gHW
 ub2JwZmOqgk3/E3t+8weUexKIHeT76obGtXxlJ8EIqnj+geVklFpL8E/roKWEAieBvnZQ3CAY2Cr9
 Wn2am3ruyjKx+RWEu5lSR8YS6W70gA0wKJZY8oXALbNOkA0Ns3RkeHqg38OYllOAn6Qs=;
Received: from 013.lax.mailroute.net ([199.89.1.16])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wSi9u-0002uF-1c for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 28 May 2026 21:20:54 +0000
Received: from localhost (localhost [127.0.0.1])
 by 013.lax.mailroute.net (Postfix) with ESMTP id 4gRKCc3CbwzlfvpG;
 Thu, 28 May 2026 21:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
 content-transfer-encoding:mime-version:references:in-reply-to
 :x-mailer:message-id:date:date:subject:subject:from:from
 :received:received; s=mr01; t=1780003242; x=1782595243; bh=I12j2
 5VCYwg/eP7OFqKC7AWmW1SqWD4Hv21aKHsbeYc=; b=1s4LvMvczAx6JmhLS5XjZ
 P8n2QyyhjbWFIQxTusKrR5/8YsLjUN9U9GM6MRsl9hMzOHhhoFRX+1LoHyGGJIP9
 Esv/9Muj17EdZ/vg8cH9q3rj+JGcxz6l82larwak+qQrgxFFhVI1RyCiC4sqMulQ
 2ZCvgEY/D1tbcq8eFdCW/lMekWmrpxB1mF67xT9CfHN83c+0kod5xSrCR6bt7pSQ
 BvCV+o03tsjltI8v/ZMQjszrvCIlwhlR+zTChSk/wKtySBA3KODnL2t8LJtgpyr+
 hztMIOsUAe0MVFkNyo+h01B1nPZkOqNyWYrGOI8De45vMQrjUyuSW0/s7UNFh9to
 g==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id jA_wXzr8kzzc; Thu, 28 May 2026 21:20:42 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: bvanassche@acm.org)
 by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4gRKCY3HF5zlfddp;
 Thu, 28 May 2026 21:20:41 +0000 (UTC)
To: Jaegeuk Kim <jaegeuk@kernel.org>
Date: Thu, 28 May 2026 14:20:25 -0700
Message-ID: <60ab44127999ea22ca05aa6c552f305bfaef9898.1780003055.git.bvanassche@acm.org>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
In-Reply-To: <cover.1780003055.git.bvanassche@acm.org>
References: <cover.1780003055.git.bvanassche@acm.org>
MIME-Version: 1.0
X-Headers-End: 1wSi9u-0002uF-1c
Subject: [f2fs-dev] [PATCH 1/4] f2fs: Prepare for supporting delayed bio
 completion
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
From: Bart Van Assche via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Bart Van Assche <bvanassche@acm.org>
Cc: Bart Van Assche <bvanassche@acm.org>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Use bio frontpadding to allocate memory for a work_struct when
allocating a bio.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 fs/f2fs/data.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 8d4f1e75dee3..1659a57a6d5b 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -40,12 +40,17 @@ struct f2fs_folio_state {
 	unsigned int		read_pages_pending;
 };
 
+struct f2fs_bio {
+	struct work_struct work;
+	struct bio bio;
+};
+
 #define	F2FS_BIO_POOL_SIZE	NR_CURSEG_TYPE
 
 int __init f2fs_init_bioset(void)
 {
 	return bioset_init(&f2fs_bioset, F2FS_BIO_POOL_SIZE,
-					0, BIOSET_NEED_BVECS);
+			   offsetof(struct f2fs_bio, bio), BIOSET_NEED_BVECS);
 }
 
 void f2fs_destroy_bioset(void)


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
