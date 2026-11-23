Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAFF4606A31A
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 23 Nov 2026 18:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Vp/cLsv2;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=cxy5wLyK;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=bIRbCsnQ;
	dkim=neutral header.d=laveeshbansal.com header.i=@laveeshbansal.com header.a=rsa-sha256 header.s=zoho header.b=NQCKQ6Re
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:List-Owner;
	bh=NKSEfnN7Xno9koos1TdhhmItQJLIKj1VM8uZzaWIR7Y=; b=Vp/cLsv28N8gwL5mZ80b0mV0s7
	qKc4R8R7DN0Ipr3+rccr3D4nS1eMg31rtXROXYN8SK2DlV1bySTJaRi0bUlBCaLvaSiiVk80qcv4p
	cxdinBf7UjaEYYKGpzVgm3QzIayGYwIAvIcBVzzpkrEa/7UDE9Hbuit1PFPJRQIWUAmU=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xVYfw-0000000058y-2eYZ;
	Mon, 23 Nov 2026 18:22:00 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <laveeshb@laveeshbansal.com>)
 id 1xVYfv-0000000058r-2ZrM
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 23 Nov 2026 18:21:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=gQaw9Vk9+tQPLXBi7VU6YjTxlhQ/2eyTFTJHqY1EySE=; b=cxy5wLyKhJ6Np3exbtLPucluLr
 T9TnZwFc0zhtAYXfBqQFBVuNMlbNv84ibvqse5Bg2AMs3UMwxqPakKXwpOsZSaYK4riDTLKbSZ1s5
 qXUMHAXQxsU/8EnezLqFWGB77ktEsFCCN+7RuB9+oyD9JzCRwJWXdKvvezE1eSJ7ibXg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=gQaw9Vk9+tQPLXBi7VU6YjTxlhQ/2eyTFTJHqY1EySE=; b=bIRbCsnQDB9/6K3jusc2JXe2JQ
 IV3QN5DE76zRptS2MUjup8eBXcKwktBUcLBuohjkcHDLoweXSjh+V0vlMrp6UZQkwrEgBzl3iDNzO
 AbFmse9zdZ+by9Nhxwd7aTUu+k4Kz7G7LO0fDTCBTIo28qccg6lPgsd6RCc2j8/mw3Uk=;
Received: from sender5-op-o15.zoho.com ([165.173.182.15])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xVYfu-0000000033q-47yV
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 23 Nov 2026 18:21:59 +0000
ARC-Seal: i=1; a=rsa-sha256; t=1795458104; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=ZGtKsHgNSS/ZvE454aeZ4AE+SU6epq4GNeJPu7klKjDuRv3LiUCnhTXu1PkRi11JRd6vWNnWoYGe4mdLS0dDpxztXw23z/jCLdtitDKoXLNA8fmKa/zJ7hvPeO2wDQ+Xg5UJwTxrg7NtRLHHM5lqfDHlnb2M+KXFNipxrBAOXP8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1795458104;
 h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=gQaw9Vk9+tQPLXBi7VU6YjTxlhQ/2eyTFTJHqY1EySE=; 
 b=mVe3qmonBAON3Sybd7Y2rbLUZm4fZ71en/kHkS6sMDponfrmdeGIq+g4enwAHTvTUrHmppBHdTmCSC636KC0Lol70c7dIrODsHXUlyFVAJ1dZeC2oEChSpUWa13RaU/Mfw11Ggr9Uaw+NQZg1vZkgnOJefqeYz1ZlnNi4A9M3LM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=laveeshbansal.com;
 spf=pass  smtp.mailfrom=laveeshb@laveeshbansal.com;
 dmarc=pass header.from=<laveeshb@laveeshbansal.com>
DKIM-Signature: a=rsa-sha256;
 b=NQCKQ6Rex/xA5RTPVCehzSMw9tNJYBOBZANzW1pFmeU5Qd1fm/53Q6FGRcSMvNE3pMq+/m9bw4BYc7RRdFnlGCjUjrvFaOcaLm95ekTOWwsRgsMxOQY9jy0tN6eElJC3988gyYYMBE6lYIBE7SaMq4rj93IqoxusfYgYL5b3Gvs=;
 c=relaxed/relaxed; s=zoho; d=laveeshbansal.com; v=1;
 bh=gQaw9Vk9+tQPLXBi7VU6YjTxlhQ/2eyTFTJHqY1EySE=;
 h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1795458102373833.7656003546538;
 Mon, 23 Nov 2026 10:21:42 -0800 (PST)
From: Laveesh Bansal <laveeshb@laveeshbansal.com>
To: Christoph Hellwig <hch@lst.de>
Date: Mon, 23 Nov 2026 10:21:36 -0800
Message-ID: <20261123182136.63256-1-laveeshb@laveeshbansal.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261123093134.GA23224@lst.de>
References: <20261123093134.GA23224@lst.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-ZohoMailClient: External
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xVYfu-0000000033q-47yV
Subject: Re: [f2fs-dev] [PATCH] blk-crypto: avoid fs reclaim under
 profile->lock in the fallback
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 "Theodore Y. Ts'o" <tytso@mit.edu>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, Eric Biggers <ebiggers@kernel.org>,
 linux-fscrypt@vger.kernel.org, linux-crypto@vger.kernel.org,
 Jaegeuk Kim <jaegeuk@kernel.org>,
 syzbot+20d60aafd9a0d1f2a380@syzkaller.appspotmail.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Christoph

Thanks for the review. v2 moves the NOIO scope into
blk_crypto_hw_enter()/blk_crypto_hw_exit(), and into
blk_crypto_reprogram_all_keys(), which takes the lock directly:

https://lore.kernel.org/r/20261123181408.62972-1-laveeshb@laveeshbansal.com

Thanks
Laveesh


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
