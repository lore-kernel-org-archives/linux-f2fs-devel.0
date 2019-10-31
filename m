Return-Path: <SRS0=XOwI=YY=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89B7DCA9ECB
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 31 Oct 2019 18:26:44 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 589A1208E3;
	Thu, 31 Oct 2019 18:26:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="eWxEqUms";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="BWJODXaL";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ibOAU5Tm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 589A1208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1iQF9f-0001ie-W8; Thu, 31 Oct 2019 18:26:44 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from
 <BATV+4fa4615b85c97fbb822c+5912+infradead.org+hch@bombadil.srs.infradead.org>)
 id 1iQF9e-0001iS-Cw
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 31 Oct 2019 18:26:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=xGKoferNKfspRbnIISs596AcbXhd0qJEbsy99cjQW1s=; b=eWxEqUmsLSaK0By+EmqYf/AWNm
 YGW+9xKis46wqKHiGSMJndZEVu4OYroXDj+XyZ+p9H/+HgHNJ6IzyuDxfL20V8Y1Hwz+bvbqDR8+U
 kAl8nqPXmLby97/jRAQBiYfO8rcLopIOAodFC69UO8TdwwmtIWYsehWF2CmqsltEYNjM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=xGKoferNKfspRbnIISs596AcbXhd0qJEbsy99cjQW1s=; b=BWJODXaLuzAmCdtnX7rXjMQKAO
 kNFUCr6l1/2H2cY/O1EK0+G4vLon8YC5AbAz7TnZtfEBvk3edjXaStF5B6Vo6SozV7Z+LeP25pDyc
 2DwpKtxAGCaqMvGTqG1mvvp/IFpjcJBrJhYGgk4SRWY8oOHABPJbGZxZdBsKfXZBWH/U=;
Received: from bombadil.infradead.org ([198.137.202.133])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1iQF9d-00BBcF-Bc
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 31 Oct 2019 18:26:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=xGKoferNKfspRbnIISs596AcbXhd0qJEbsy99cjQW1s=; b=ibOAU5TmxrFii45Kim/G2t/2E
 SDu1BNQ2603yUpmstCvG9YOw9+45EfSx6bxgKgmWFummCnqG9qVS+aamDLoccHltMk7s/UmEm4i4R
 yOYAMeDbHe5btNNkCL46bf/ncTNnj915yc6uNmS51gpFVym5Pj+xkMXxYacyckfiaP34cL4ub3OQU
 X/LDZrHu+Zk7USfXuHNCTwKrt3qYjS+UVopJbcmZ67xospYg7al5CBPmLV2Afi6Yk5ROp0sHLcflG
 YhhXLHP8OoARskk8vxmv9sLQVU/2mdsYCYeHD1FU3woCN6gu2D+lgtSQ2b3RKwFoyZRRxIcztfn/q
 SPWu+FafA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red
 Hat Linux)) id 1iQF9R-0003Ro-PR; Thu, 31 Oct 2019 18:26:29 +0000
Date: Thu, 31 Oct 2019 11:26:29 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Satya Tangirala <satyat@google.com>
Message-ID: <20191031182629.GE23601@infradead.org>
References: <20191028072032.6911-1-satyat@google.com>
 <20191028072032.6911-7-satyat@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191028072032.6911-7-satyat@google.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Headers-End: 1iQF9d-00BBcF-Bc
Subject: Re: [f2fs-dev] [PATCH v5 6/9] scsi: ufs: Add inline encryption
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

>  	/* Transfer request descriptor header fields */
> +	if (lrbp->crypto_enable) {

Maybe we want a little inline function so that we can use IS_ENABLED
to make sure the compiler eliminates the dead code if crypt config
option is not set.

 a) don't have to define the crypto_enable if the config options are
    not set

> +		dword_0 |= UTP_REQ_DESC_CRYPTO_ENABLE_CMD;
> +		dword_0 |= lrbp->crypto_key_slot;
> +		req_desc->header.dword_1 =
> +			cpu_to_le32((u32)lrbp->data_unit_num);
> +		req_desc->header.dword_3 =
> +			cpu_to_le32((u32)(lrbp->data_unit_num >> 32));

This should use ther upper_32_bits / lower_32_bits helpers.

> +static inline int ufshcd_prepare_lrbp_crypto(struct ufs_hba *hba,
> +					     struct scsi_cmnd *cmd,
> +					     struct ufshcd_lrb *lrbp)
> +{
> +	int key_slot;
> +
> +	if (!cmd->request->bio ||
> +	    !bio_crypt_should_process(cmd->request->bio, cmd->request->q)) {
> +		lrbp->crypto_enable = false;
> +		return 0;
> +	}
> +
> +	if (WARN_ON(!ufshcd_is_crypto_enabled(hba))) {
> +		/*
> +		 * Upper layer asked us to do inline encryption
> +		 * but that isn't enabled, so we fail this request.
> +		 */
> +		return -EINVAL;
> +	}
> +	key_slot = bio_crypt_get_keyslot(cmd->request->bio);
> +	if (!ufshcd_keyslot_valid(hba, key_slot))
> +		return -EINVAL;
> +
> +	lrbp->crypto_enable = true;
> +	lrbp->crypto_key_slot = key_slot;
> +	lrbp->data_unit_num = bio_crypt_data_unit_num(cmd->request->bio);
> +
> +	return 0;

I think this should go into ufshcd-crypto.c so that it can be stubbed
out for non-crypto builds.  That also means we can remove various
stubs for the block layer helpers and just dereference the fields
directly, helping with code readability.


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
