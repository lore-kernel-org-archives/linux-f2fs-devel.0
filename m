Return-Path: <SRS0=YoBC=3D=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32124C33C9E
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 14 Jan 2020 21:24:18 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 009E924656;
	Tue, 14 Jan 2020 21:24:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="fkmwnFe+";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="cKo92U6D";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="BddM2F3H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 009E924656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1irTfd-0005Ia-HO; Tue, 14 Jan 2020 21:24:17 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <ebiggers@kernel.org>) id 1irTfc-0005IS-4r
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 14 Jan 2020 21:24:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=HuuIXbOJ388ULq86cf/i4f6wAE3MmNF2plKIyFh59fU=; b=fkmwnFe+fY5amQPpJdZ5KuDZGz
 ajnDK4KztuZz+RlAzScvE1NIs6kXccfxvgsGPpb2Tbg76UT6W35xT/eGRDRn6wso6opwmCpXRvqv3
 ihYo1GoAmpYAe7rSdqR2QNrXdUPZOoNfOE8k+dCyBUYpdkJkhKKeTMS0cZXmDrZGAt3o=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=HuuIXbOJ388ULq86cf/i4f6wAE3MmNF2plKIyFh59fU=; b=cKo92U6Df0PM5krKi1L2YefYE7
 orCfcAAxISXwLktuCup5hB0TORS9hBbBni4tU0QD8ybNHJz8fyVFvLBEKUNjQyF+Jrua6lLDH2Fia
 XHhb9dhAhBcwCxRS1h3+pOsvCSpOzuZJqgRSzKfMRSQNyzW3w4FK8DxwdA9oM8q01bg4=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1irTfb-003SYZ-4h
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 14 Jan 2020 21:24:16 +0000
Received: from gmail.com (unknown [104.132.1.77])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 4F26E24656;
 Tue, 14 Jan 2020 21:24:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1579037049;
 bh=aGWleahYjUMp+oq+LHbLyk7aqRexeZp1Q7zVEa2V+PU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=BddM2F3HQyL+zyp/NCjh1ksC6Ks5xnobKc3HJiLEelHGXS6fRmiu4+TrQ9D+KxPuF
 ZxeMIbNC3YS5xU6MMKLUcIphzYNSt4c/BtgZcpe7ofl5xTZo2G2aQ73b2M3jzYsOUm
 lIACnPmJWBtg1/i5ywycEKS6N0GXbFf6eFtXjDJM=
Date: Tue, 14 Jan 2020 13:24:07 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Satya Tangirala <satyat@google.com>
Message-ID: <20200114212407.GF41220@gmail.com>
References: <20191218145136.172774-1-satyat@google.com>
 <20191218145136.172774-3-satyat@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191218145136.172774-3-satyat@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Headers-End: 1irTfb-003SYZ-4h
Subject: Re: [f2fs-dev] [PATCH v6 2/9] block: Add encryption context to
 struct bio
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
Cc: linux-scsi@vger.kernel.org, Kim Boojin <boojin.kim@samsung.com>,
 Kuohong Wang <kuohong.wang@mediatek.com>,
 Barani Muthukumaran <bmuthuku@qti.qualcomm.com>,
 linux-f2fs-devel@lists.sourceforge.net, linux-block@vger.kernel.org,
 linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Wed, Dec 18, 2019 at 06:51:29AM -0800, Satya Tangirala wrote:
> +static inline void bio_crypt_set_ctx(struct bio *bio,
> +				     const struct blk_crypto_key *key,
> +				     u64 dun[BLK_CRYPTO_DUN_ARRAY_SIZE],
> +				     gfp_t gfp_mask)
> +{
> +	struct bio_crypt_ctx *bc = bio_crypt_alloc_ctx(gfp_mask);
> +
> +	bc->bc_key = key;
> +	memcpy(bc->bc_dun, dun, sizeof(bc->bc_dun));
> +	bc->bc_ksm = NULL;
> +	bc->bc_keyslot = -1;
> +
> +	bio->bi_crypt_context = bc;
> +}

The 'dun' argument should be const.

- Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
