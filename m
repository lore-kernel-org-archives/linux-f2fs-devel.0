Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F5F606A326
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 25 Nov 2026 05:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=JUByu3Uc;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=UPwZYnzT;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=aCXtUUZX
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:MIME-Version:References:Message-ID:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:List-Owner;
	bh=Sg5X+I5/XRYcnVikWSqR8w4sRMEOjZdeMUQVsGcC8pA=; b=JUByu3UcU/XE3D5To0YvLynFQo
	Nye2calsSByD7HKMjK4san6YF5BBSNEIgqjunRyBX5CIyse3uKH89cNnpTBmeFlp5Cs0Zny87wMRJ
	0BVgmc9+OXTW0mLGvLcRwcw/ZisYu52NirfuiXzJTrYcBcFaRwasG5E/sp3Zb7cPyYCw=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xW5dB-000000005oh-00nz;
	Wed, 25 Nov 2026 05:33:21 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <hch@lst.de>) id 1xW5d9-000000005oZ-381f
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 25 Nov 2026 05:33:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=SfHDJG8N1lUb7/rR9etOXwdGral5sYZou2C8hxd7w/w=; b=UPwZYnzTJ1b/iSnBpg1y6/koUP
 BHgZytIZ3MHTnJN8ipAwpmXq/zfMEECNXpnZdbe30tTIgU6TtygHjCSv0+2Ti8BEzfA3SPut7UCp4
 zNv6Oybf9u915phpYlYR8B46TciTvog+yfMBMFYUj9pw0k/E+RUGEenUg1xAj8S9ZvOA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=SfHDJG8N1lUb7/rR9etOXwdGral5sYZou2C8hxd7w/w=; b=aCXtUUZXcqIZzFdZJ40wDC7vDE
 bJJedhtPpF13PCvieVDiejPJgM/AWHwRJH371WkkvceINZfKlNCmFDDobCWJbtwgzbMyDX9XX115y
 B6EpEu1nvE4N56lzAr9ogKOZYg/im0egb/YeLbbOTk3eBb8ExHqAUzGyjGya8bHFLSA0=;
Received: from verein.lst.de ([213.95.11.211])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xW5d8-000000004h7-0Pwr
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 25 Nov 2026 05:33:19 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 57F7568AFE; Wed, 25 Nov 2026 06:33:08 +0100 (CET)
Date: Wed, 25 Nov 2026 06:33:08 +0100
From: Christoph Hellwig <hch@lst.de>
To: Laveesh Bansal <laveeshb@laveeshbansal.com>
Message-ID: <20261125053308.GA20407@lst.de>
References: <20261123181408.62972-1-laveeshb@laveeshbansal.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20261123181408.62972-1-laveeshb@laveeshbansal.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Score: 0.0 (/)
X-Headers-End: 1xW5d8-000000004h7-0Pwr
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
 Jaegeuk Kim <jaegeuk@kernel.org>, Christoph Hellwig <hch@lst.de>,
 syzbot+20d60aafd9a0d1f2a380@syzkaller.appspotmail.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

(and I agree with Eric that killing the allocations is also useful..)


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
