Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F9F1606A32C
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 25 Nov 2026 08:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=cHmp8ShD;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=AjDsUBF+;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Qe5jxVg8;
	dkim=neutral header.d=laveeshbansal.com header.i=@laveeshbansal.com header.a=rsa-sha256 header.s=zoho header.b=Fdy1V4G2
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:List-Owner;
	bh=TbQDGXmU4eQUX1v6T4hBMzyrBFKcKQj7kdZnT70Mh5k=; b=cHmp8ShD+Da0juqKURnBnSisq7
	wQpbRMoNyPXZG+3wWZor7zRbBDh+WVLpMOMT1uST7NVtUlOzhvsMwgxr5RLCbQxVIwfx+de7nm1S6
	KVgl4Lc9cxuVW74zaED1JJnU39o49cdOCknimj4p3RXyNEcQ0Esnp2pRGGSDxMo4Ftbk=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xW8FW-000000005RS-0RZW;
	Wed, 25 Nov 2026 08:21:06 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <laveeshb@laveeshbansal.com>)
 id 1xW8FU-000000005RK-0n4R
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 25 Nov 2026 08:21:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=7WgrRTlfNplaG0KIoL2QZuOhxkVxnuaykkwfTzH0Qo4=; b=AjDsUBF+ZkIGaQh3UqowGv9k9U
 TjeXet0EfsFu3a061M4KFvU7BrhWAMszmyMVQ2AoXyMbrcmfc4p2g4ssUAmzhaks9ht8DlAhrNVyO
 nZ2Gqj0JDpfnGl0dHvUrh7XdBeCtAg7aKdu3FZjDMlni1InKh8Zj70IggNQ0KIyAvgKM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=7WgrRTlfNplaG0KIoL2QZuOhxkVxnuaykkwfTzH0Qo4=; b=Qe5jxVg8QYoNEOKDeArkarYpkf
 /73nerSODkFJxNmGr+st4ShtNMcazMI/mEZxLpmr/if0724/GHyAPqJQb8NwCCTR+LUmCjmIpnZvX
 Mjb70oL0COVQVDLKyHUqq/HD1OvrW471CFGBrlbSV4s0Hik59c4FhWqHchyopWLBWtMA=;
Received: from sender6-op-o15.zoho.com ([165.173.180.15])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xW8FR-0000000021c-0KTX
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 25 Nov 2026 08:21:04 +0000
ARC-Seal: i=1; a=rsa-sha256; t=1795594850; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=HaCv45zGfIFSwef5XCKPMVa4ihwxLlklvsi+f0iObqtaqLlMaWeRyR7jIcLJTwSQTO3/9P/dcL8wHr5d7BTlChHQmKZGPD3X7mtd0WVsfJEkF5aSfhdodmNYHL4Z2Gc6phMZo/ifG0YhGI2bfpIL3Xikw/FL54sdyIpWucAswhs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1795594850;
 h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=7WgrRTlfNplaG0KIoL2QZuOhxkVxnuaykkwfTzH0Qo4=; 
 b=OA/FCdUwPlk+XCHDKBbU+HeIVKFyqIKzUGWPFk43+ESZTezWZpivD9kBMOZsEr/f4zgLIGg5TLYY5eEgM1g2PbUn6cdEDa58tTeOX00SHhr7nu8zCkJW+O1EOCWnrfGEwlF2UNQCRenKaSyCP5eL5xySoT0mhyg1Cz1E26ImpBs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=laveeshbansal.com;
 spf=pass  smtp.mailfrom=laveeshb@laveeshbansal.com;
 dmarc=pass header.from=<laveeshb@laveeshbansal.com>
DKIM-Signature: a=rsa-sha256;
 b=Fdy1V4G2HguZdxRwK7LZ1EA/JSaOqRZtjLFvdMJfPB9t15/hSz7DCoU6MZ7NeIEJZ297skj1vqTSZ+g9oWc0o9ViBNlKHz65HfSbN9z7hU7lrtqFqDM+U2y3z+/n5YEMlg2ESONFjE9oazs3pGobB8Y22r9kXXZ0wzhJlBx8020=;
 c=relaxed/relaxed; s=zoho; d=laveeshbansal.com; v=1;
 bh=7WgrRTlfNplaG0KIoL2QZuOhxkVxnuaykkwfTzH0Qo4=;
 h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 17955948481371018.7221762782647; 
 Wed, 25 Nov 2026 00:20:48 -0800 (PST)
From: Laveesh Bansal <laveeshb@laveeshbansal.com>
To: Eric Biggers <ebiggers@kernel.org>
Date: Wed, 25 Nov 2026 00:20:34 -0800
Message-ID: <20261125082034.78219-1-laveeshb@laveeshbansal.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261125014454.GA2461@sol>
References: <20261125014454.GA2461@sol>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-ZohoMailClient: External
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xW8FR-0000000021c-0KTX
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
Cc: Jens Axboe <axboe@kernel.dk>, "Theodore Y. Ts'o" <tytso@mit.edu>,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-block@vger.kernel.org, linux-fscrypt@vger.kernel.org,
 linux-crypto@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
 Christoph Hellwig <hch@lst.de>,
 syzbot+20d60aafd9a0d1f2a380@syzkaller.appspotmail.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Eric

Thanks for the review. v3 returns the flags from blk_crypto_hw_enter(),
rewords the comment and drops the version from the stable tag:

https://lore.kernel.org/r/20261125081417.77674-1-laveeshb@laveeshbansal.com

Thanks
Laveesh


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
