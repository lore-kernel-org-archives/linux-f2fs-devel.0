Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46ACDCD98DA
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 15 Jun 2026 16:38:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-Id:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=svb2f5C3Napdn6ZNbESapX4VVl2MIDIRp/LxsXApmIY=; b=XZXtXTo3hPYAgx9TRSpoMSQkUS
	qIhedqerZ1soq6ZfWJGzEqky7yZyqxfnEXDUXuOn1oK/WBjTAnZOZYW7acKP+dG963+/LfeGT6uBv
	M61i3r6GtWVrGvCvnDBM6FH8vlpUtQOKtGDZ+O2mAKA6ZdATPErjGmuA9dfUjev/Wu3o=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wZAKM-0006eY-RN;
	Mon, 15 Jun 2026 16:38:20 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <m.lobanov@rosa.ru>) id 1wZAKK-0006eQ-Jo
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 15 Jun 2026 16:38:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=hDHUogP752j9O3lgSAFEToo3DiQGtGOJDaqcRV9H/X8=; b=WG96+7ZjNQ/Vf8aKJd+9q5KaJa
 cPaCTWo6597izAQPXUEeOgp+/QuT8p1P9784R7s6aPPYTUWtv66CVkIODSu+BwXF1Sgb3LAfmz7hD
 BsMKtWX3jtHG64Mqs+vrpEySfXKAKmZ0lxWfyQPnTl0E2vDgN/7hEE54f3UtNjB8Leuc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=hDHUogP752j9O3lgSAFEToo3DiQGtGOJDaqcRV9H/X8=; b=GH/SCJLhjZs/pz1BcVO/+uKDLr
 Mx1yqVC9DApiJS5vS78aQiZIGkxHEit1ksizIH3Bjn0S8EL4acN/NZzBQSCPcpZd3V4sZ12G+JWB3
 r8+t9kT1FgvSE7tj1kmbpFuMQX8Oi6CQo+1TD0Bm7jLVWMs58kqop9mIioXgujoRjxA8=;
Received: from [178.154.239.147] (helo=forward100b.mail.yandex.net)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wZAKE-0001SR-JA for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 15 Jun 2026 16:38:18 +0000
Received: from mail-nwsmtp-smtp-production-main-63.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-production-main-63.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c1e:489c:0:640:8d6b:0])
 by forward100b.mail.yandex.net (Yandex) with ESMTPS id 2EEEB808AB;
 Mon, 15 Jun 2026 19:38:03 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-63.sas.yp-c.yandex.net (smtp)
 with ESMTPSA id xbSonHOfGa60-yzOG0B13; 
 Mon, 15 Jun 2026 19:38:02 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rosa.ru; s=mail;
 t=1781541482; bh=hDHUogP752j9O3lgSAFEToo3DiQGtGOJDaqcRV9H/X8=;
 h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=iyQpzMoZ5jdfbwV/PFpR8od58YlqnrBTeNXd/wJln/O3cnJWVrkKOFNaxN3MZi5T7
 6mS7grFAjgKMncvLU5LW4i6xjNQSS2wxwU2+fcggL7+VfzoQ7XFSCKeIdSMyFu+D5f
 Jyg0/g13/7cwOqA/DXQnsvDRNqmC0eMNqahYDTmI=
Authentication-Results: mail-nwsmtp-smtp-production-main-63.sas.yp-c.yandex.net;
 dkim=pass header.i=@rosa.ru
To: Jaegeuk Kim <jaegeuk@kernel.org>
Date: Mon, 15 Jun 2026 19:37:59 +0300
Message-Id: <20260615163759.52180-1-m.lobanov@rosa.ru>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <ajAiNyPcqd4Blujr@google.com>
References: <20260615113613.20762-1-m.lobanov@rosa.ru>
 <ajAiNyPcqd4Blujr@google.com>
MIME-Version: 1.0
X-Headers-End: 1wZAKE-0001SR-JA
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: read COW data with the original
 inode during atomic write
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
From: Mikhail Lobanov via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Mikhail Lobanov <m.lobanov@rosa.ru>
Cc: lvc-project@linuxtesting.org, m.lobanov@rosa.ru,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 daehojeong@google.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hi Jaegeuk,

Looks good to me, thanks.

Mikhail


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
