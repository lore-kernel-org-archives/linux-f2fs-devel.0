Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D384C55173
	for <linux-f2fs-devel@archiver.kernel.org>; Sat,  1 Aug 2026 18:29:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:Message-ID:Date:To:Sender:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=AY28MI3F+fGicMCxmS/Z187or1W+nMPJB9KEyWhCBho=; b=LTYaeKHCvo3LZxBZ1Bzfk9iJn6
	oNuHK5Q9ygSxn8qDb2WC5Td7yIJEpFpQTC3HT00Hy5+ZgYoc5MS8oC+I04vg/G7ds85Me66jxQ5uX
	NvxLIuyqQrU/ZKYqyuoCOg7c1o2h+uwb+MXpOF7WV5yGOZZYB85s8xDny+pdep+TP3sU=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wqES7-0004Wy-Q9;
	Sat, 01 Aug 2026 18:28:56 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <purchase@ywjinfabag.com>) id 1wqES7-0004Ws-EG
 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 01 Aug 2026 18:28:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Subject:Content-Transfer-Encoding:Content-Type:
 MIME-Version:Message-ID:Date:To:From:Reply-To:Sender:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=G12DNz9LXNvC71ZjjAQ/RsPfc3QjhQamDtiFoBHGnk8=; b=cK1bpS+3h8V6LsgMwntOIPRFxM
 tMTOyeckKxJB3twRGlHPys07ZnH0sdY0OIzKyFB5ikysZ6zG5CJA7IUHUqPoSmV8enDPiNtteGzX8
 er2WrYM+Hd2wxljOjlQR8uTzvkcf8IxxUL98BrhXUK+l6Sv2BEgaXQ8trEi7njZJVQ3U=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Subject:Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Date:To:From:Reply-To:Sender:Cc:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=G12DNz9LXNvC71ZjjAQ/RsPfc3QjhQamDtiFoBHGnk8=; b=P
 zA1clk2sl0d5TvoXhYcFVGeAzFXU+GG0bKMb/ZxbeQk4ZhTSo5oLeQgPd66pNQ+H/KOc8KghxEuQB
 fJcgw2L1eXwlL7Dd+XOHai/ULJfn8haUz0/1UFaT2tfvVFi9CN98kBYnNC+mdy4WJ2p8guKByNHpB
 8e3B41apBv+qg3ew=;
Received: from mail.ywjinfabag.com ([198.44.49.143])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wqES7-0000i3-R1 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 01 Aug 2026 18:28:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ywjinfabag.com; s=dkim; h=Content-Transfer-Encoding:Content-Type:
 MIME-Version:Message-ID:Date:Subject:To:From:Reply-To:Sender:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=G12DNz9LXNvC71ZjjAQ/RsPfc3QjhQamDtiFoBHGnk8=; b=W1dzp7oUUVIQhdFpU2BXkOe8gM
 zIBk1N28mR8Xtb+tZgf6maCBGNg0tFMuiBLi/Z2eYUxzfJwt3u3qA2lMKUYfVKU/NI5v81TqWoT+m
 dedG0gLQIjQdiouMbHZ7r5IBkth9d4sJdD/J2e5fv5bsapBhsSyKYny24DsN1c2NEplw=;
Received: from [107.174.34.144] (helo=107-174-34-144-host.colocrossing.com)
 by mail.ywjinfabag.com with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.96)
 (envelope-from <purchase@ywjinfabag.com>) id 1wqES2-004NbK-1u
 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 01 Aug 2026 14:28:50 -0400
To: linux-f2fs-devel@lists.sourceforge.net
Date: 1 Aug 2026 14:28:49 -0400
Message-ID: <20260801142849.43751BCEC8CE20E7@ywjinfabag.com>
MIME-Version: 1.0
X-SPF-Fail: YES
X-VA-Spam-Flag: YES
X-Headers-End: 1wqES7-0000i3-R1
Subject: [f2fs-dev] [SPAM] Re:
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
From: Purchase via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: princeventures@yahoo.com
Cc: Purchase <purchase@ywjinfabag.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello

Attach is a request for quotation.

Regards
Import
Tara Designs (Phils),Inc.
2F SFB2 PEZA Loakan Rd.
2600 Baguio City, Philippines


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
