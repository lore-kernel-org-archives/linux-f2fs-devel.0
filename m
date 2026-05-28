Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A007CD5BD5
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 28 May 2026 21:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:Message-ID:Date:To:Sender:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=0q6z8sb2z+RCH7YbS1g9I25+NbUITBuEBbEAh7psoN0=; b=lgSfgw8LkAowYrygFWb2z8Fjjh
	oOe4VdXQeqKTOhb5o35l6kT7YJ0ZaKGmmlVJjDcgvDK18PfLI9D8zCE1dN1FV37o+49DSlJCVpYDa
	xNXzU91eZy46xAjvryenDa4atyyYW7qpzuMgshoJ7SA+1lBriKvfyJPEnbsxNfFtTqDw=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wSi9y-0005Ec-6b;
	Thu, 28 May 2026 21:20:55 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <bvanassche@acm.org>) id 1wSi9v-0005EV-Tb
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 28 May 2026 21:20:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=tTLyCBOyIAl1XNEwL8WEC98F/5LnOn3K7X7JalJgr1w=; b=ftiMQx37S1y5uVSCV7qIjZ/EBO
 My10jxFLbdvaRuR4ND1WDMl0IaypltWNhUzYO2DHNaukNcr1VseVESh6DLLLv9MyFCuQLKOomCzmH
 Un20Ad/d555bGlNUvhnNeaeFw0al8PhEFeKtzoCuG1Qm/eqyYxkKEr5HFPQ0stHR5Jcs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=tTLyCBOyIAl1XNEwL8WEC98F/5LnOn3K7X7JalJgr1w=; b=D
 MPV7xj3UQDHKH+ErMwNYFI64gQn2s84+H4CM/2ZOJp5QYWtkYlm0VHBkEBL6fHn8NWxTsGWYivaC7
 Qdr34sB/xz9aKYKWF4WnyaaZzkUqBsC0db7a10w6/jTAm9gbeXW0eQ8m+ySRLq9otJ0QJQKVh2UtG
 bqYtfNLyhJn5OvLA=;
Received: from 013.lax.mailroute.net ([199.89.1.16])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wSi9s-0002uD-HH for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 28 May 2026 21:20:53 +0000
Received: from localhost (localhost [127.0.0.1])
 by 013.lax.mailroute.net (Postfix) with ESMTP id 4gRKCZ6jpbzlfddn;
 Thu, 28 May 2026 21:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
 content-transfer-encoding:mime-version:x-mailer:message-id:date
 :date:subject:subject:from:from:received:received; s=mr01; t=
 1780003240; x=1782595241; bh=tTLyCBOyIAl1XNEwL8WEC98F/5LnOn3K7X7
 JalJgr1w=; b=3Swd5FvOTg+9iPd+rAW7mv9V/MOI7bvoFRBelR80tD5F+kBKiMp
 zKO3ShM7QFr6gVBBabR14HVAHIZrDFkv64Ks9GCXfo38iRRJz/OvWPD+Ivj6+44y
 1jtv4ERqYtbuaihq/JuujDOr1LOH96JsleUi4Sxoho7mj6vQI0Q1r/+7rwckI+kr
 G0s21TKe3miST21ql5SxxH3am8zdX72IDrp8ggAdI6AKjzsPVt7HGFvPdsBxvnoN
 p2Otybqd5Z+syXlI4/ertFjuJlrYxsd7q3tEC5cLvw4ncGdrszuvtDzBY7gGSxqm
 MReEgwVxzIN2SypZEZHlJtYD4Z2An4c9M5g==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 9L9dZH3IyWFP; Thu, 28 May 2026 21:20:40 +0000 (UTC)
Received: from bvanassche.mtv.corp.google.com (unknown [104.135.180.219])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: bvanassche@acm.org)
 by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4gRKCW743kzlh2rg;
 Thu, 28 May 2026 21:20:39 +0000 (UTC)
To: Jaegeuk Kim <jaegeuk@kernel.org>
Date: Thu, 28 May 2026 14:20:24 -0700
Message-ID: <cover.1780003055.git.bvanassche@acm.org>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
MIME-Version: 1.0
X-Headers-End: 1wSi9s-0002uD-HH
Subject: [f2fs-dev] [PATCH 0/4] Reduce the time spent in interrupt context
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

Hi Jaegeuk,

This patch series reduces the amount of time spent in interrupt context for
completing write bios. Please consider this patch series for the next merge
window.

Thanks,

Bart.

Bart Van Assche (4):
  f2fs: Prepare for supporting delayed bio completion
  f2fs: Rename f2fs_post_read_wq into f2fs_wq
  f2fs: Split f2fs_write_end_io()
  f2fs: Run f2fs_write_end_io() asynchronously

 fs/f2fs/compress.c |  2 +-
 fs/f2fs/data.c     | 62 +++++++++++++++++++++++++++++++---------------
 fs/f2fs/f2fs.h     |  8 +++---
 fs/f2fs/super.c    | 13 +++++++---
 fs/f2fs/sysfs.c    |  2 ++
 5 files changed, 59 insertions(+), 28 deletions(-)



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
