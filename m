Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E33E2109C028
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 25 Mar 2026 15:03:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:MIME-Version:References:Message-ID:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nzWsJz7g2fUdUFzIoNbZFQb066OGKxpJZs1X8SITb8Q=; b=RnpyzZ2qlqP0jHzMFUvdTcKWHL
	sQDLudLezzv8hyvgwI4XQ2tOTcYYIFgsNSkSXOPLpi55anH9ifc2RGXBjFnsICvSGEMBLG+uZ75RQ
	LPbHXSajiw9ev6A15cdCdaQ/omJw55QRMo8Udr8VlrdnKElaqyYIsFIKX2flNqusJyXU=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1w5Plq-0005tq-Ji;
	Wed, 25 Mar 2026 15:03:46 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <hch@lst.de>) id 1w5Plo-0005tk-Sj
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 25 Mar 2026 15:03:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=q2c/xT6XJwEKIiHJmT8558WCfx4UGROZ9aBuiUzMmX0=; b=QmH6Mgxuvtzob5OK7yq+WNkdYk
 BcoeQacN5Irl5EC8uTyqzcPU3/ulCUAKX6y0cF6fbytp6OKN2MPMu4QVHadVPKCKoAx4jw+aipf/L
 /07BQv7DJManKgGk2ANl0MtB2CbDxrZZfFSY0etcKCMBUJJVAAOwoCh49iEYlsJ/a+ss=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=q2c/xT6XJwEKIiHJmT8558WCfx4UGROZ9aBuiUzMmX0=; b=NiSdypMgUnlRkUDRLfQDInuwQZ
 3Dav9LiGLoiy7DNNLKXM5atItEjoob56EfmEdQ5gl84ThDdyCVsgRi/97awozuxiRVvIK18oPaYoc
 pPn9YAjC6Qr9OHUXslqTj96G9IuOrSh7n5OpGCXOBAqK2qZrzLTNsORwP4Wp+9IAf+mg=;
Received: from verein.lst.de ([213.95.11.211])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1w5Plo-0006TN-66 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 25 Mar 2026 15:03:44 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id DAD7968CFE; Wed, 25 Mar 2026 08:57:37 +0100 (CET)
Date: Wed, 25 Mar 2026 08:57:37 +0100
From: Christoph Hellwig <hch@lst.de>
To: Andrey Albershteyn <aalbersh@kernel.org>
Message-ID: <20260325075737.GD952@lst.de>
References: <20260319170231.1455553-1-aalbersh@kernel.org>
 <20260319170231.1455553-5-aalbersh@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260319170231.1455553-5-aalbersh@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Headers-End: 1w5Plo-0006TN-66
Subject: Re: [f2fs-dev] [PATCH v5 04/25] fsverity: introduce
 fsverity_folio_zero_hash()
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
Cc: fsverity@lists.linux.dev, ebiggers@kernel.org, djwong@kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, hch@lst.de,
 linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Thu, Mar 19, 2026 at 06:01:51PM +0100, Andrey Albershteyn wrote:
> Helper to pre-fill folio with hashes of empty blocks. This will be used
> by iomap to synthesize blocks full of zero hashes on the fly.

This should probably be merged with the previous patch.



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
