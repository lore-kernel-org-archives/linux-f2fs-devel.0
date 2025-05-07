Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94983C369DC
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  7 May 2025 07:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Gc7bwPK1UkMMCbTGtWO624cIFeqKIcmt9tM+qZpZXkM=; b=cXpq784tkx4bygzWifndzvtLZa
	i37qd21+yy5j6PWszXEfNodiIl/kJUUnvP3uMzocbO/2qKbwyGwLjOg8PmmojKn6e44arAlie1w5h
	igvrA7dOl+K45TDMJHb6IZwqiYhNWR8Yvdy7p4fna0+YQ15R3QFDl2BaBlh5tswA8YGg=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1uCYup-0000oX-W4;
	Wed, 07 May 2025 07:10:03 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1uCYul-0000nV-TS
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 07 May 2025 07:09:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=+HNCeEBiCibp2G5Pf7g4ULlLSkkSnZ1SxOCj9EVlvtA=; b=ihtuYtyDuiA/WDM2MpcBjOl96K
 DduqzM5frWVsvzesnpcDiYGotSbhfdVNqC1s6TOkiKSyWbKvzP0AJNYQlQBsRQVY3tDjuRWMnAEbt
 yMmURPFUWS8AQLtChVuVmNGhcnvIzA+j7kN0Bz0e6qEC3ibf5eb25YOnlA9bCbR70jO4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=+HNCeEBiCibp2G5Pf7g4ULlLSkkSnZ1SxOCj9EVlvtA=; b=b4Zu0AEZpbrDUzp3aMInjUVE9W
 ouRgqApogwdwTMn4mmHPUrKmrdjHaDvD5PJ2WfOEXzjitj3Cg12CblxEEMYQ5DrQIGeJFEAJ8rk/0
 q4qt0WlNOlxUVqYEo6gC69TGuhUoOCe+ckxjAe8fsz/EuiOJ/UJs+MWsCCJlKi258TGo=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1uCYuW-0001wu-5t for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 07 May 2025 07:09:59 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id AE47F44222;
 Wed,  7 May 2025 07:09:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27951C4CEE7;
 Wed,  7 May 2025 07:09:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1746601778;
 bh=QdsZwbUfeSm//b7NNqX/50NGWSbdSUMX1Gm8cyHuCXw=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
 b=sJ30fFQLJ/5HlQtH851cjhL9gN6YAiW7d2ZmkZoV2IMchhlaLleIorpmmDjHU2IV3
 F4B1cUJxRQro/bT6yeKppu18oU9TJ1GvdupZ9/zDQL9pYoqtgd5x5/4qs/38eS/Mlg
 pdoFiD3JQmpXSq0KN6TnwdSzyn4H+RUY8YljEdg9pPJfZ8Oh4D+LskuWnWk4Jt2uJL
 LTar5q8HLohse9V3qKf44Y+aAe2wYdvoZgQ9zYzTJgDJIOiCtsYNgbSdW+AIVxZiyK
 FDRouWHzq28mxwVwBvsLDpPZcieL4RjKRBMf34txMPtfdhPFXKFQnJxbTacsKMf2jU
 gWYaf4+dkEDTA==
Message-ID: <9b8e24ac-500e-4d53-acbe-a9f97794a498@kernel.org>
Date: Wed, 7 May 2025 15:09:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Christoph Hellwig <hch@lst.de>
References: <20250505092613.3451524-1-hch@lst.de>
 <20250505092613.3451524-3-hch@lst.de>
 <aab08ad6-22db-44f3-9924-97e096cb0619@kernel.org>
 <20250507064437.GA31135@lst.de>
Content-Language: en-US
In-Reply-To: <20250507064437.GA31135@lst.de>
X-Headers-End: 1uCYuW-0001wu-5t
Subject: Re: [f2fs-dev] [PATCH 2/4] f2fs: don't return
 AOP_WRITEPAGE_ACTIVATE from f2fs_write_single_data_page
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
From: Chao Yu via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Chao Yu <chao@kernel.org>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 5/7/25 14:44, Christoph Hellwig wrote:
> On Wed, May 07, 2025 at 02:28:55PM +0800, Chao Yu wrote:
>>> diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
>>> index e016b0f96313..ce63b3bfb28f 100644
>>> --- a/fs/f2fs/compress.c
>>> +++ b/fs/f2fs/compress.c
>>> @@ -1565,10 +1565,7 @@ static int f2fs_write_raw_pages(struct compress_ctx *cc,
>>>  						NULL, NULL, wbc, io_type,
>>>  						compr_blocks, false);
>>>  		if (ret) {
>>> -			if (ret == AOP_WRITEPAGE_ACTIVATE) {
>>> -				folio_unlock(folio);
>>> -				ret = 0;
>>
>> Previously, for this case, it will goto out label rather than writing
>> left pages?
> 
> Indeed.  Is that the right thing to do here?

IIRC, once it failed to write one page, it redirties all left pages, and tries
to rewrite them again, it can avoid fragment as much as possible.

So can we keep original implementation here?

Thanks,



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
