Return-Path: <SRS0=+J46=JF=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A046C433B4
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  8 Apr 2021 00:52:57 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DC67611C9
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  8 Apr 2021 00:52:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DC67611C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1lUIul-0003hx-2r; Thu, 08 Apr 2021 00:52:55 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <ebiggers@kernel.org>) id 1lUIuk-0003hm-50
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 08 Apr 2021 00:52:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=MUVlio1XF0xJ5WwHqUot/9KNqXrKYvgPFvXuJAO80ug=; b=bxgNMiY2SAIVVymENVIJIcnB6D
 xHfbOWdkHDW88Vvk+2EtcfXjEguv3DNmT+eEwHiVgTsCMpN/R4QuIbeEBFcDqTjoIH0khpEhi5Pv2
 cGuP0c5MzsHQbpFWBS72b2YhSnoWZABmM91O8SZPj/6ZRwAb9fgPHFloNQfzMP1iXIaY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=MUVlio1XF0xJ5WwHqUot/9KNqXrKYvgPFvXuJAO80ug=; b=ikKHVO73zFb9dvwAQGx8udoh8f
 jJcSy9wAhs1n/Rx/M3izd1mnTOivyMhyU+sUjlQQQzKpcG5hhH5mr/qlolCRH6zUAXd77WyBZhNzc
 IR88O0aSFW7yp/7HLakhCFlha04/tUG5Hub/lbQS9yRf8xtiMMZX9zkTHGYuYhJYGNf4=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1lUIua-0008Te-8V
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 08 Apr 2021 00:52:54 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id AE5ED611C1;
 Thu,  8 Apr 2021 00:52:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1617843152;
 bh=0IqB+o5pa4cpP+r10TYU8b1OpH+60OMa+LdDlFSSCM0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=f2r/GaunjIWONcwRT1lMgR7osxHYWBpPEZDHV4yjK3NopxXoDK66FDXcLJnabeevk
 KSZAt6H6VVm5eToznjaloTdlE0n1lEJ0q1F+7Cwl2b59JrQOXsM8yq5TX6S9C7aebP
 Ul2EutKg1X9UwTMXc2MF04N2WCuBnTF+F6cQ3y/lD91tFi8CYpAEY8vxtqayzY/sY8
 dkdOXu+mRQbGtwaB85nTOqK7J6aWu8AwvxP1ejIN5v8i9SxJEsEPHlbyOHGUYcX2R4
 YddI6pEgJ/hgNGk0uE3CmXX8b70Nyjh4pE9IxcpgRzj4s3G/ls75vJWuqJg/WZuaph
 CKzr5887DS28A==
Date: Wed, 7 Apr 2021 17:52:30 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Shreeya Patel <shreeya.patel@collabora.com>
Message-ID: <YG5TzqDwHXxvlvz1@gmail.com>
References: <20210407144845.53266-1-shreeya.patel@collabora.com>
 <20210407144845.53266-2-shreeya.patel@collabora.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210407144845.53266-2-shreeya.patel@collabora.com>
X-Headers-End: 1lUIua-0008Te-8V
Subject: Re: [f2fs-dev] [PATCH v7 1/4] fs: unicode: Use strscpy() instead of
 strncpy()
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
Cc: tytso@mit.edu, kernel test robot <lkp@intel.com>, drosen@google.com,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 kernel@collabora.com, adilger.kernel@dilger.ca, linux-fsdevel@vger.kernel.org,
 jaegeuk@kernel.org, andre.almeida@collabora.com, linux-ext4@vger.kernel.org,
 krisman@collabora.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Wed, Apr 07, 2021 at 08:18:42PM +0530, Shreeya Patel wrote:
> The -Wstringop-truncation warning highlights the unintended
> uses of the strncpy function that truncate the terminating NULL
> character from the source string.
> Unlike strncpy(), strscpy() always null-terminates the destination string,
> hence use strscpy() instead of strncpy().

This explanation is a bit misleading.  It would be clearer to phrase this in
terms of fixing how overly-long strings are handled: start returning an error
instead of creating a non-null-terminated string.

> 
> Fixes: 9d53690f0d4e5 (unicode: implement higher level API for string handling)

There should be quotes around the commit title here.

- Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
