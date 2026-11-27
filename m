Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A89C606A31E
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 27 Nov 2026 06:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Y0lwrPzE;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=YlNEdc4B;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Zh683vEI;
	dkim=neutral header.d=laveeshbansal.com header.i=@laveeshbansal.com header.a=rsa-sha256 header.s=zoho header.b=TiQ3U15R
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:List-Owner;
	bh=+ON0WC4o01U3OiaJaJkRnmoqpjNIWmqfohBqlY2O72Y=; b=Y0lwrPzEiA67KBj5QghFgl/dgq
	Z0JLIDInLArVccYnsQe2WBk+lwPqpAmNPeeMO8VhNqUeG83BGyjsRMyYEjKzHgMj4rWGssp5NFWxj
	2dg7//1kVfBqVflrIiBDvLhs1mJKtTA0ebvvk3pWoQW6066GV64lLiRFkuC2VqpoRBZs=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xWpPq-000000000KC-2oSV;
	Fri, 27 Nov 2026 06:26:38 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <laveeshb@laveeshbansal.com>)
 id 1xWpPo-000000000K5-2XRa
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 27 Nov 2026 06:26:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=bCNn9r8VG4aa0r4Am+eSfDy/QqMZMCKrbKXiHll/bkU=; b=YlNEdc4BvTg3oo0eCjnshg/OOT
 y3j7ZZFxTWJ5NxiYxXuibNjgZ6bikHuiDgL0Zb6cOCHSjpjmRSmFVlN6lgIehkyRUZq0ESR9n+H5w
 FDlbusZAh9csoqNRzj3Pog3F9ykqp/nCR3k1hwXQVf1E5BdtUDe4dN5Qc2hdspuU7BSg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=bCNn9r8VG4aa0r4Am+eSfDy/QqMZMCKrbKXiHll/bkU=; b=Zh683vEI2iSxdv4lnvAbPT/Vbq
 k3UrMxtXepfzMxXYlxv7sMnAKevGS0qsYNfxm6IM+Jf0ts16uZl1gQRmicYqRLQf3BtMNRa7iwxfv
 XPqOqmUEAPRPmoyPHME1xpYJqkGZLNv23cx+b16Qhg9ES2mmw5nrCbMLyC9aeFy+/n9c=;
Received: from sender6-op-o15.zoho.com ([165.173.180.15])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xWpPm-000000001Bp-3tZo
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 27 Nov 2026 06:26:36 +0000
ARC-Seal: i=1; a=rsa-sha256; t=1795760783; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=Iq8+3O6SVynT2p7WX05aK+b7q9YoMkkRNFV3sfhmUDfefXMc9GdZKVzfp/G0qBb1pOMuqmV/5+IHeRerNmIZm5po6BzF/fMCCOhdyI3qgjiPB4wkQDxMYUV+sHdKFHroRNu3ak2OD32zXAtp151sSQvwnJgECfySt0Zo1vmy6+Y=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1795760783;
 h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=bCNn9r8VG4aa0r4Am+eSfDy/QqMZMCKrbKXiHll/bkU=; 
 b=jJlsb++oCttRggNA3bAp3KJoKJ1RkFzyGC50RoUTVTkfejfzP9YOJTUtyWcUATRbLTPS37mCMA479lREhVRYJpOuhpsqUP7iLn6GRW0yVnlTHE1IK1FnKZn1gqLWc6gtN9d0dNg3gLz5yCKHXlyQ3UPFzpYswkr1XcYIoZVH/k4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=laveeshbansal.com;
 spf=pass  smtp.mailfrom=laveeshb@laveeshbansal.com;
 dmarc=pass header.from=<laveeshb@laveeshbansal.com>
DKIM-Signature: a=rsa-sha256;
 b=TiQ3U15RQrizMzkNM3/UKGIzpdsVJHRMduzq6A5gQoelzNgKqo8ooAwP+xzJq5kblOfAfid1MiquAAU9ljG7zIJZT1EH54+nKavCqm0BIEdy6FfPeGk6yRjCfsLl3WW0eZ1ofQgZMGdhKvFcpUpDkQlLUl8xClgnQanoHNLTCwM=;
 c=relaxed/relaxed; s=zoho; d=laveeshbansal.com; v=1;
 bh=bCNn9r8VG4aa0r4Am+eSfDy/QqMZMCKrbKXiHll/bkU=;
 h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1795760780464754.4038009804824;
 Thu, 26 Nov 2026 22:26:20 -0800 (PST)
From: Laveesh Bansal <laveeshb@laveeshbansal.com>
To: Christoph Hellwig <hch@lst.de>
Date: Thu, 26 Nov 2026 22:26:17 -0800
Message-ID: <20261127062617.29510-1-laveeshb@laveeshbansal.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261125053308.GA20407@lst.de>
References: <20261125053308.GA20407@lst.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-ZohoMailClient: External
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xWpPm-000000001Bp-3tZo
Subject: Re: [f2fs-dev] [PATCH v2] blk-crypto: use a NOIO scope while
 holding profile->lock
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

I sent v3 to address Eric's comments on v2.

blk_crypto_hw_enter() now returns the saved flags and
blk_crypto_hw_exit() takes them, instead of keeping them in the profile.
The comment is reworded and the version is gone from the stable tag:

https://lore.kernel.org/r/20261125081417.77674-1-laveeshb@laveeshbansal.com

I did not carry over your Reviewed-by since the code changed. If you
are ok with v3, please re-add it.

Thanks
Laveesh


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
