Return-Path: <SRS0=KF8H=3Z=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 420DFC35247
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  5 Feb 2020 20:47:22 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B2B12072B;
	Wed,  5 Feb 2020 20:47:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="k57JxSqh";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="dzpZS1Sn";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="gjvMPyIR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B2B12072B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1izRZx-0001Kb-Ai; Wed, 05 Feb 2020 20:47:21 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <ebiggers@kernel.org>) id 1izRZw-0001KT-0A
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 05 Feb 2020 20:47:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=vP8sWlSSKbm16MiUxDuucKVihCQaRg3k2eJIHeg5/C8=; b=k57JxSqh6wM2mMQX3m2JCkAHJL
 O8mCk0sFWc/qZa4A2pMumaGHcUH9JolSpft12NgC1Dfw5NNxbbYHUG333yIKkbXW9bLN9N4MXlWgm
 opyul+FE0Zva36rSmE206Y+OW+F1zGd9+QWEklQdJpS25+HcxXNJGO6FxTbwtyvNhYVA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=vP8sWlSSKbm16MiUxDuucKVihCQaRg3k2eJIHeg5/C8=; b=dzpZS1Sn6uuCyhx4lOXgoeZIR3
 zf2o451++DdVSEjWcqAVl4+JjTSmeywCtCT47dRCs5lovW0E1XhK4eYXF4FPyLWp9xwIbPBH46YOt
 Fi9w50Jrzk9vLTaQZolLj5VHV6x55clsFiVqQhABWUVwm4TvspCVCHvARIohrGMD4/rw=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1izRZu-00BIij-Vk
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 05 Feb 2020 20:47:19 +0000
Received: from gmail.com (unknown [104.132.1.77])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 294D02072B;
 Wed,  5 Feb 2020 20:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1580935633;
 bh=+ZS+NN3+LYtwsrpUFYDvOFcmW2Zu5fsUZcqSPkhg4lU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=gjvMPyIRhoMGBaCI7MUINX99uO8A+WSahEkQxe0NwqVase8Kt3OdsPyTgQdAddwpe
 sPqnpxP6yhP0i05boyaZUGSbzavu3uTCqEKyTBI1gAUbygv8J4fhmq4I+NrO1bIdbO
 3fvVcT2HL0T8TSI8+QzmXbu1arwf2m7l9btJBDKA=
Date: Wed, 5 Feb 2020 12:47:11 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Satya Tangirala <satyat@google.com>
Message-ID: <20200205204711.GA112437@gmail.com>
References: <20191218145136.172774-1-satyat@google.com>
 <20191218145136.172774-7-satyat@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191218145136.172774-7-satyat@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Headers-End: 1izRZu-00BIij-Vk
Subject: Re: [f2fs-dev] [PATCH v6 6/9] scsi: ufs: Add inline encryption
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
 linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Wed, Dec 18, 2019 at 06:51:33AM -0800, Satya Tangirala wrote:
> @@ -2472,6 +2492,13 @@ static int ufshcd_queuecommand(struct Scsi_Host *host, struct scsi_cmnd *cmd)
>  	lrbp->task_tag = tag;
>  	lrbp->lun = ufshcd_scsi_to_upiu_lun(cmd->device->lun);
>  	lrbp->intr_cmd = !ufshcd_is_intr_aggr_allowed(hba) ? true : false;
> +
> +	err = ufshcd_prepare_lrbp_crypto(hba, cmd, lrbp);
> +	if (err) {
> +		lrbp->cmd = NULL;
> +		clear_bit_unlock(tag, &hba->lrb_in_use);
> +		goto out;
> +	}

The error path here is missing a call to ufshcd_release().

- Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
