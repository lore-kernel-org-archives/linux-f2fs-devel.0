Return-Path: <SRS0=phsH=6O=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48B31C83001
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 30 Apr 2020 07:11:29 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 178152082E;
	Thu, 30 Apr 2020 07:11:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="VCGVFSej";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="Cm84Ao1f";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="WOFPPzjW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 178152082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1jU3M0-0007ZS-LU; Thu, 30 Apr 2020 07:11:28 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <ebiggers@kernel.org>) id 1jU3Lz-0007ZH-Hd
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 30 Apr 2020 07:11:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=HjWR1lp0ZRnNneKkSU2cx4A4xXHq7bPEjIqcgpuH/fE=; b=VCGVFSejAveuo6RLbblp1DIpQt
 9YhjO8qSuUT62mWZRHg/lsRBeFDmqqKgYWab3OeHtYVmk/au+mp6ASDb8sz7tXNTeBZlkPRZJXoJ1
 rBllA8ubujC6rom2Te87CRbHiEP2RYxh3pdHueiUcdbTYAtZEUOnffMFJLnLg0ERm/hU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=HjWR1lp0ZRnNneKkSU2cx4A4xXHq7bPEjIqcgpuH/fE=; b=Cm84Ao1fhFp4NglWvtjMSzlG+X
 0CcEeinRFR+w5xNrNb19nh6iUJxPO+0br0pI+iQVvwjpYyqQL5yvxrkHAMQK8yswVPR0+uiqfbcgp
 5fdYOh/QPwrom21cUL3kDB1rHxP7nkUEkrO38CPqWcmluo1QsX6fE9MhiLHKNSOl7BH8=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1jU3Ly-0034tU-FC
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 30 Apr 2020 07:11:27 +0000
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net
 [107.3.166.239])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 9395B2082E;
 Thu, 30 Apr 2020 07:11:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1588230680;
 bh=s4l9m6sDXPEeXraZWK6wigMAQG4mKfDnswEgISGvnS4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=WOFPPzjWYYk044D2ZqXzNihzxX9ZCs2Qval8oNKQ5jkpKlAK60K2eo54sIknbSZka
 GDRnyym19w1K4XbzS+5amFW2gGHEZuL1NSNHCZhxN7SQk9dq7oQAebzSEcU3f7G90B
 oW5WU2MvB6hnKQWldY8GUKtiTgXqapiPHdOoqk98=
Date: Thu, 30 Apr 2020 00:11:19 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Satya Tangirala <satyat@google.com>
Message-ID: <20200430071119.GC16238@sol.localdomain>
References: <20200429072121.50094-1-satyat@google.com>
 <20200429072121.50094-5-satyat@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200429072121.50094-5-satyat@google.com>
X-Headers-End: 1jU3Ly-0034tU-FC
Subject: Re: [f2fs-dev] [PATCH v11 04/12] block: Make blk-integrity preclude
 hardware inline encryption
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

On Wed, Apr 29, 2020 at 07:21:13AM +0000, Satya Tangirala wrote:
> Whenever a device supports blk-integrity, the kernel will now always
> pretend that the device doesn't support inline encryption (essentially
> by setting the keyslot manager in the request queue to NULL).

"the kernel will now always" => "make the kernel", so that it's clear that this
patch is doing this.  I.e. it's not describing the state prior to the patch.

> diff --git a/block/blk-integrity.c b/block/blk-integrity.c
> index ff1070edbb400..b45711fc37df4 100644
> --- a/block/blk-integrity.c
> +++ b/block/blk-integrity.c
> @@ -409,6 +409,13 @@ void blk_integrity_register(struct gendisk *disk, struct blk_integrity *template
>  	bi->tag_size = template->tag_size;
>  
>  	disk->queue->backing_dev_info->capabilities |= BDI_CAP_STABLE_WRITES;
> +
> +#ifdef CONFIG_BLK_INLINE_ENCRYPTION
> +	if (disk->queue->ksm) {
> +		pr_warn("blk-integrity: Integrity and hardware inline encryption are not supported together. Unregistering keyslot manager from request queue, to disable hardware inline encryption.\n");
> +		blk_ksm_unregister(disk->queue);
> +	}
> +#endif
>  }

Make this shorter by removing the mention of the keyslot manager?:

	pr_warn("blk-integrity: Integrity and hardware inline encryption are not supported together. Disabling hardware inline encryption.\n");


> diff --git a/block/keyslot-manager.c b/block/keyslot-manager.c
> index b584723b392ad..834f45fdd33e2 100644
> --- a/block/keyslot-manager.c
> +++ b/block/keyslot-manager.c
> @@ -25,6 +25,9 @@
>   * Upper layers will call blk_ksm_get_slot_for_key() to program a
>   * key into some slot in the inline encryption hardware.
>   */
> +
> +#define pr_fmt(fmt) "blk_crypto: " fmt

"blk-crypto", not "blk_crypto".

> +bool blk_ksm_register(struct blk_keyslot_manager *ksm, struct request_queue *q)
> +{
> +	if (blk_integrity_queue_supports_integrity(q)) {
> +		pr_warn("Integrity and hardware inline encryption are not supported together. Hardware inline encryption is being disabled.\n");

"Disabling hardware inline encryption" to match my suggestion for the other one?

- Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
