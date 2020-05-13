Return-Path: <SRS0=oeUr=63=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C250EC433DF
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 13 May 2020 18:20:01 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4150920659;
	Wed, 13 May 2020 18:20:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="E3blUwjn";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="REq24g8N";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kt83iOzn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4150920659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1jYvz6-0006Vv-IR; Wed, 13 May 2020 18:20:00 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <ebiggers@kernel.org>) id 1jYvz6-0006VV-10
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 13 May 2020 18:20:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=vL9TSDwZJwvgtrB74UuUVgQcq1ZtRh8rQNHJtKdZUf8=; b=E3blUwjn/EMHnmKSPUXJ1CCi3f
 pQqFuRp0/H0T4IsHbX/6rr9JBm19jOyzIID5ne/f4H0dZ/SusPA+pMKVTeVl/11gXgW7z7nyzEznd
 tICIkqE0R+qRQS/hJsEZv/p75RtoCCXlqo77oWiYItf3Cy9ENfmo89U11XvDVNZy9C+U=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=vL9TSDwZJwvgtrB74UuUVgQcq1ZtRh8rQNHJtKdZUf8=; b=REq24g8NanLctsVMOlOclI6W67
 9r6JLCKnH4lnAMayabWtDV3ezzauOSKGL+VYXwOgJzSmtRnYHcB08acF8IoNa9Q6A3jpbXKxTqQM9
 1YO+iEf7XNImoyjtCDEMLY+jy8Qj5jCYVLDdDwHDiPh0gb1x0HnRJFyuMb3iRjjmZ0QQ=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1jYvyP-00EEYm-5u
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 13 May 2020 18:19:59 +0000
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net
 [107.3.166.239])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 4805120659;
 Wed, 13 May 2020 18:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1589393952;
 bh=SfJxDaSxm0hnHBUQQlW7klJYEBeSvPqH0A5X4yUESvo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Kt83iOznWMDCO7CN/KhYA7OhhIp+dJ8qjppZYlYd2ZsvQlDtaSkePzBNQ0yXT9cgV
 07AV6jluBY8Dd8bzEHcoaYXYWMU8a1QHqZ3QPQR/S4o5OUCUD8o717ISAFRdVYw9yE
 DQeGKgRVoKhyPjUqErvy36jlZzCZ/Mg+LtCftVEc=
Date: Wed, 13 May 2020 11:19:10 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Satya Tangirala <satyat@google.com>
Message-ID: <20200513181910.GH1243@sol.localdomain>
References: <20200430115959.238073-1-satyat@google.com>
 <20200430115959.238073-9-satyat@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200430115959.238073-9-satyat@google.com>
X-Headers-End: 1jYvyP-00EEYm-5u
Subject: Re: [f2fs-dev] [PATCH v12 08/12] scsi: ufs: Add inline encryption
 support to UFS
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
 linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Thu, Apr 30, 2020 at 11:59:55AM +0000, Satya Tangirala wrote:
> @@ -8541,6 +8568,13 @@ int ufshcd_init(struct ufs_hba *hba, void __iomem *mmio_base, unsigned int irq)
>  	/* Reset the attached device */
>  	ufshcd_vops_device_reset(hba);
>  
> +	/* Init crypto */
> +	err = ufshcd_hba_init_crypto(hba);
> +	if (err) {
> +		dev_err(hba->dev, "crypto setup failed\n");
> +		goto out_remove_scsi_host;
> +	}
> +

Due to changes in v5.6, this is jumping to the wrong error label.
It should be 'free_tmf_queue'.

- Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
