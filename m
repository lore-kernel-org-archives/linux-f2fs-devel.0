Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BA1AECAAD5
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 31 Aug 2022 02:40:41 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1oTDeg-0001we-Pp;
	Wed, 31 Aug 2022 02:40:38 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <rdunlap@infradead.org>) id 1oTDee-0001wY-0X
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 31 Aug 2022 02:40:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=vkC7YbGzcZlYm9RaWlAt34O4KbVTqpqAYy7ynMzo02g=; b=V93FBh6uzcqXKz2louhTNadGiz
 O5HPI8YxiJOJjOfUt7f4Mhw/TR+vCKMS8a0Y/ZMYQoyZfHYGFN5lsOEroId/xvp1J/JSci0ARttiW
 KBPCov9aYgDhIdrxvkBCpfmYFy/rOJqlKLzUZJ4A0xJ1iXSLSSwQ2bo6kYve4RvYNZcY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=vkC7YbGzcZlYm9RaWlAt34O4KbVTqpqAYy7ynMzo02g=; b=VuPNaMT0pMnd7N8QaqxjqZzKRV
 PPGLN1iArsS9buF9k/OiuYgKXapWh7WU/8hIwrJQgY8IhZpoQUYJBMAfuthz3MgnxciHuFnDmupjb
 rhjiKp3zkgeJWj+oLcHliaP+1LqvyRq8TeFcC6CHkob/FT0G+VM5OOZg92SX9vSdGjF8=;
Received: from bombadil.infradead.org ([198.137.202.133])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1oTDeZ-0004HG-Md for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 31 Aug 2022 02:40:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
 Message-ID:Sender:Reply-To:Content-ID:Content-Description;
 bh=vkC7YbGzcZlYm9RaWlAt34O4KbVTqpqAYy7ynMzo02g=; b=mfp/bZ3g9+9Ju4lllH4EyuLxsq
 XiHrpf3oC7uydhxIXrb1d20M9XXEMoN7cxOttnon7E9HOdiMUEXRbZFVls0AtN3n6IZQjPJDWWKaw
 HCwC1U8YtykW1o8aBsw22nbmSdFnLKWg/L4gRxTmR/KljgI5EA39pDSQcs2BCg/x8r2FJPoFF37zm
 kFAMakiv6ePHxSPVIQo/RJmggB2oXMMO1398z+2VMW3eJSf4/k3l/cEaFpCVO5l2OoUJ1HtXbUU23
 x79TJGuNsC6UhlGGREjxC9RxquEzfjNqlRcMvhZE2nhk+1n7dwr+9wsADFtBi/G70U0U1dq8vJjHq
 8XBjFtow==;
Received: from [2601:1c0:6280:3f0::a6b3]
 by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1oTCQy-002ydd-FD; Wed, 31 Aug 2022 01:22:24 +0000
Message-ID: <ab1a33e5-01b9-79d4-662e-44c6e0e74113@infradead.org>
Date: Tue, 30 Aug 2022 18:22:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Content-Language: en-US
To: Theodore Ts'o <tytso@mit.edu>, Al Viro <viro@zeniv.linux.org.uk>
References: <20220829235429.17902-1-rdunlap@infradead.org>
 <Yw56rVwBRg0LbC41@ZenIV> <Yw6Hp8l/7p3wbiGq@mit.edu>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <Yw6Hp8l/7p3wbiGq@mit.edu>
X-Headers-End: 1oTDeZ-0004HG-Md
Subject: Re: [f2fs-dev] [PATCH] Documentation: filesystems: correct
 possessive "its"
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
Cc: Christian Brauner <brauner@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 linux-doc@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-xfs@vger.kernel.org, Seth Forshee <sforshee@kernel.org>,
 linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net



On 8/30/22 14:56, Theodore Ts'o wrote:
> On Tue, Aug 30, 2022 at 10:01:33PM +0100, Al Viro wrote:
>> On Mon, Aug 29, 2022 at 04:54:29PM -0700, Randy Dunlap wrote:
>>>  compress_log_size=%u	 Support configuring compress cluster size, the size will
>>> -			 be 4KB * (1 << %u), 16KB is minimum size, also it's
>>> +			 be 4KB * (1 << %u), 16KB is minimum size, also its
>>>  			 default size.
>>
>> That one doesn't look like possesive to me - more like "default size is 16KB and
>> values below that are not allowed"...

I have to disagree about the possessive part...

> That being said, it could also be rewritten to be easier to
> understand.  e.g., "The default and minimum size is 16kb."

but sure, it can be rewritten.

thanks.
-- 
~Randy


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
