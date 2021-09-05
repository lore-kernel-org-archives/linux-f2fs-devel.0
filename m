Return-Path: <SRS0=AKYf=N3=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_REPLYTO_END_DIGIT,
	HEADER_FROM_DIFFERENT_DOMAINS,LOTS_OF_MONEY,MAILING_LIST_MULTI,
	MONEY_FREEMAIL_REPTO,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F22A0C433F5
	for <linux-f2fs-devel@archiver.kernel.org>; Sun,  5 Sep 2021 13:27:39 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE3DA60F45;
	Sun,  5 Sep 2021 13:27:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org AE3DA60F45
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.sourceforge.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.sourceforge.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:Message-ID:Date:To:Sender:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=MFQXqJj1/INKsQsVHfGj8HE8q/5BsKnivQKlWlCoJqY=; b=I95wD3SBCviWqyFEp/kYKOSI1A
	TEOcGzepWMus0Dk4yvbwk8o4ROWIWL052xAfxSOUtjzaauMsOMEiLI4QDoHO0BW84OXje7S7gQTda
	+ab6+a0v1wC84jkCJrxHSaphlfI7sM190URtauYRj7OScLE7L7+H6VbkDhs9tCFLXB7E=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1mMsBO-00017I-OH; Sun, 05 Sep 2021 13:27:38 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <lsk20@tutamail.com>) id 1mMsBC-00015F-Ex
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 05 Sep 2021 13:27:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Subject:Content-Transfer-Encoding:Content-Type:
 MIME-Version:Message-ID:Date:To:From:Reply-To:Sender:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=mVAOURMRXkR0R9wzqMM9dqLEH+kgl3vQjjw5oyKUSdY=; b=hMZO4Nyh6CBrGJZzdbPK3mROAC
 YWk7VQWUIhAY7BANgUNhG5wnOicv7grcLbjg0T8EWLtS44JxnTPK4qfP4z4F+XoEmyvYpqZpaVkEX
 WL5KiETBY/5NQVv/uKzLOFnsb0PqRfFom5IFQZWBSwCFfvv4h+FOZShswE7/oZfq9508=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Subject:Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Date:To:From:Reply-To:Sender:Cc:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=mVAOURMRXkR0R9wzqMM9dqLEH+kgl3vQjjw5oyKUSdY=; b=D
 gDwWXKgYJo4doet4V1GcOkSJKQaPNRV+mUejWQwnMovdZjRTa5lUvNyYxXAypLQ4Hum+jn0uTcK7+
 CWySECNHa9hrsARTXJ0r1AOiQBQt/gxpf8SituJCA7wziJwR9kkIzFxO50qVXkUD/aCp0iYDToBPF
 asp9Y8G4TmqP71iU=;
Received: from [185.241.149.195] (helo=tutamail.com)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtp (Exim 4.92.3)
 id 1mMsB3-0001uK-Iv
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 05 Sep 2021 13:27:18 +0000
To: linux-f2fs-devel@lists.sourceforge.net
Date: 05 Sep 2021 15:27:12 +0200
Message-ID: <20210905152711.647D96D57C1FBCB1@tutamail.com>
MIME-Version: 1.0
X-VA-Spam-Flag: YES
X-Headers-End: 1mMsB3-0001uK-Iv
Subject: [f2fs-dev] [SPAM] FINAL NOTICE!
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
From: LSK Foundation via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: j.bonnafe01@gmail.com
Cc: LSK Foundation <lsk20@tutamail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

YOU'VE BEEN GIFTED 2M US DOLLARS, REPLY FOR FURTHER INFORMATION.


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
