Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C483606A328
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  5 Nov 2026 07:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=T2bJnnfQ;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Vvzz6B8L;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=MqurteUF
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:MIME-Version:References:Message-ID:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:List-Owner;
	bh=ynbnmejrIeckOy7CByukwj1tI0WGnZgWMVoNR8UPuWA=; b=T2bJnnfQCxSIPLlYO9+q4apyd6
	nMvI6MJ52nndgTucok+N8ChS0DXlYOS1pAtgAiX/KL8spWSlJq+Xcg1s+ins6TGW4RcXGF34vb1gh
	rDA8iesgFUSN5ZqFNDeWHExiwS7wGkSdYzEveLeZ8LRWvTsharE4QPB1bwqGcnsDjlDU=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xOsHI-000000001bA-1yB2;
	Thu, 05 Nov 2026 07:52:56 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <hch@lst.de>) id 1xOsHG-000000001b1-1bdG
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 05 Nov 2026 07:52:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=hzbANlYHtH0nKEF4umY8/K7880JB3GR2byaY0YcD/Jc=; b=Vvzz6B8LGAmgYkbOnrN8NVIhca
 S/UyWdsqsrxjWDcecPhR2A5SVG/oi+5L1wrRyGrS199VxBPNOfOd2L6rhnyMgZlEtWFa/ltpt3uEu
 vi8dikXKvfXxjgmvk078Bw6ADLUYEbLb+wgd02Fxo7SLSoIf1+PFTK/lfpep+itWXI3U=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=hzbANlYHtH0nKEF4umY8/K7880JB3GR2byaY0YcD/Jc=; b=MqurteUF4BUcNV6Ga5AHl6rIGs
 EsCbYY8QtGUuyWomZROjVTb4a7ItUdcV2uqSJ6c2dE5tG5JhnOju/Ftwo13orZLWQO/4DsY2vPygT
 rbgP0gWLLAJK4CVUq2NVL44ucl2oWg0Nk70l2zYYivx8s96TwrprZSQ1O/5QdCcupP9I=;
Received: from verein.lst.de ([213.95.11.211])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xOsHF-0000000061g-39F4
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 05 Nov 2026 07:52:54 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id DBB1668BEB; Thu,  5 Nov 2026 08:52:44 +0100 (CET)
Date: Thu, 5 Nov 2026 08:52:44 +0100
From: Christoph Hellwig <hch@lst.de>
To: Eric Biggers <ebiggers@kernel.org>
Message-ID: <20261105075244.GB17923@lst.de>
References: <20261104194618.103332-1-aalbersh@kernel.org>
 <20261104215749.GA3648616@google.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20261104215749.GA3648616@google.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Score: 0.0 (/)
X-Headers-End: 1xOsHF-0000000061g-39F4
Subject: Re: [f2fs-dev] [PATCH 0/5] fsverity: lift ioctl() input masking and
 runtime inode flag to VFS
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: fsverity@lists.linux.dev, Andrey Albershteyn <aalbersh@kernel.org>,
 linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
 linux-ext4@vger.kernel.org, hch@lst.de, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 04, 2026 at 09:57:49PM +0000, Eric Biggers wrote:
> Changes to 'struct inode' should be Cc'ed to linux-fsdevel as well.

Yes.  Except for that and the two btrfs/f2fs issue reported by Sashiko
this looks sane.  Please try to do a full fsverity xfstests run for
all the touched file systems.



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
