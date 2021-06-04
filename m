Return-Path: <SRS0=ofO9=K6=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5925C47083
	for <linux-f2fs-devel@archiver.kernel.org>; Fri,  4 Jun 2021 05:11:06 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 814066140C;
	Fri,  4 Jun 2021 05:11:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 814066140C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1lp26q-0002Ou-FW; Fri, 04 Jun 2021 05:11:04 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <ebiggers@kernel.org>) id 1lp26o-0002Of-KK
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 04 Jun 2021 05:11:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=aEagteCok+UeITO2xTo+X3VOH/huM7ZSHieUdI1tgag=; b=k2wE+U/YK0YoV//OhypanWOx5B
 AuXjPSf3CNZAY2OHmuhCNZIHxLcnN2AYY4GDAi5ZiZdHzfFYwLLzMdLmUFnMc8S3+HKTRbZYCzeIE
 ts5JEW0dZ4RIhWe1kX8ADtb9+veAL4tnhKnmZrPiUjRI+YeI0AMD4Lqz+c4aLUy+Ogfk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=aEagteCok+UeITO2xTo+X3VOH/huM7ZSHieUdI1tgag=; b=GAKrJXYUUl7HD4WZiG9ez5Rlhk
 QWgdU63pjewPIlmPVcU9fEzyOf1sOQHm7IPqg69lALFFYucrNr3/ZD7aQr45gHk31eu4tXCuTBA6S
 hkK3yZWZWTjeFlTrV+EgvM4p5glvlUswimwEVh6A9iFYhM3WqoC3CPbkpvZMaHKCOAXI=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1lp26h-0006p0-QE
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 04 Jun 2021 05:11:02 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5417A61159;
 Fri,  4 Jun 2021 05:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1622783450;
 bh=V08DT/rxitsvVwLGSoYGINo0EcOHL6Poon3BXcOtnjQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=FV7Xjn8SnhrZCOzpZnDtaSyDVdycfol0f/WiqodERQIWWXJ/BzKmxxqP2SPYRCo++
 DPpQVb4mvCbcbMp8flLIhti2UFv0RcBgyVBpNzskb7dm5Ih2bZXWIztospS7+SH7Jh
 0GerI02wvG2kpEgTfXozO6YmyPaSg1yH5eULAicsmKHzxYfdds/Bpnv4w7mvQqKBw4
 V2SNBaN1TMIjjQJ3SwCWdUTjsQx9D311QiixXJj8eiU3Y6HKdUHhjaKJnCxiIGF/wF
 zHzuw/LwG9VkaEql+8bhhshDbx1fxWCXNwSTDqBF5E2ZJGUdk1B+ooQkbrCwzS6MRe
 vD+d+a6wHx5Xw==
Date: Thu, 3 Jun 2021 22:10:48 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Jaegeuk Kim <jaegeuk@kernel.org>
Message-ID: <YLm12A7qKFyYYU0Z@sol.localdomain>
References: <20210603220834.1949988-1-jaegeuk@kernel.org>
 <YLmvIH/wVeKwSPCN@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YLmvIH/wVeKwSPCN@google.com>
X-Headers-End: 1lp26h-0006p0-QE
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: clean up
 /sys/fs/f2fs/<disk>/features
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
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Thu, Jun 03, 2021 at 09:42:08PM -0700, Jaegeuk Kim wrote:
>  enum feat_id {
>  	FEAT_CRYPTO = 0,
>  	FEAT_BLKZONED,
> @@ -587,6 +601,7 @@ enum feat_id {
>  	FEAT_RO,
>  	FEAT_TEST_DUMMY_ENCRYPTION_V2,
>  	FEAT_ENCRYPTED_CASEFOLD,
> +	FEAT_PIN_FILE,
>  };
>  
>  static ssize_t f2fs_feature_show(struct f2fs_attr *a,
> @@ -610,6 +625,7 @@ static ssize_t f2fs_feature_show(struct f2fs_attr *a,
>  	case FEAT_RO:
>  	case FEAT_TEST_DUMMY_ENCRYPTION_V2:
>  	case FEAT_ENCRYPTED_CASEFOLD:
> +	case FEAT_PIN_FILE:
>  		return sprintf(buf, "supported\n");
>  	}
>  	return 0;

There's no need for the feat_id enum to exist.  If f2fs_feature_show() just
always printed "supported\n", it will do the right thing.

Also, adding pin_file probably should be a separate patch.  That seems to be a
bug fix, as pin_file was mistakenly added to the per-sb feature list instead of
to the kernel feature list?

> +static ssize_t f2fs_sb_feature_show(struct f2fs_attr *a,
> +		struct f2fs_sb_info *sbi, char *buf)
> +{
> +	if (F2FS_MATCH_FEATURE(sbi, a->id))
> +		return sprintf(buf, "supported\n");
> +	return sprintf(buf, "unsupported\n");
> +}

This can just use F2FS_HAS_FEATURE(), provided that encrypted_casefold isn't
included here, which it shouldn't be (as discussed elsewhere).

- Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
