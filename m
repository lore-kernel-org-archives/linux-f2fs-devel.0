Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7615BC55ABA
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  6 Aug 2026 02:43:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1ZatN3f2FuADVZLe3Fe6n5FITq4eCjUBrxNxQSK+llk=; b=XZRzPp/+hgSoB7u3Qx1uhO82aC
	+CpUxFJaivD0b+OXuoLyBomGPwzX0RX2hxMnTRPgAewysLuTLbzF3yJNLNWlkbDD+5OdhCPcoqV1f
	5V+mPnfPMbW1Hn4uxwRJ2GL6I8+c+0PDifVT52m2cBLW2YPFjbOZxY6oFtfhWexxZU0k=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wro4y-0008BK-9y;
	Thu, 06 Aug 2026 02:43:33 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wro4x-0008BC-2u
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 06 Aug 2026 02:43:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=3Dd4WfbZRD8AwlZNKwxkeecCbyQqQzv0Fu0d9QgTe5A=; b=eYQXUbeR1824Urn60/nB+oSbdy
 5sbdNSy2+5ydjqdz47nvPR2IYrHKIWsI/6E+bSMP5Yp7Nh2vdaNaeYKePzgv2rqKHD5LJMRwKKjrc
 5EidgZGJAdN20m4AxqhaOW0aCs4UbV3nxZHIGQ+0r517jbhIcJLkNCCu5ojtKXSmmHuc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=3Dd4WfbZRD8AwlZNKwxkeecCbyQqQzv0Fu0d9QgTe5A=; b=QeTgLNQ8xyTZjPHiRW7mtj4aMe
 TPh4C4/VGZDaLhQBBYH6YmFHxLCC9osRgieh1XINs5DbkBqlzruiWiSfpW1OIJadpBUoAP3flu0PW
 MugjMD0rP9dkCTK/cbwD+0sDngY1AFo9BdjJ/RmcNyK5+oH/+X71OOAjFAfGF2WTIP0w=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wro4z-0002hw-Ss for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 06 Aug 2026 02:43:31 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1504542AED;
 Thu,  6 Aug 2026 02:43:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E43231F000E9;
 Thu,  6 Aug 2026 02:43:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785984205;
 bh=3Dd4WfbZRD8AwlZNKwxkeecCbyQqQzv0Fu0d9QgTe5A=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=DmiSGt7v55DpXjqGKGwreEr/0/+HyWbb9No7WARKH1FD/9oSGysuVnDU+ZBRKoPYG
 mL/s8eMZsIzF0oX+22FOiRPWyEaz6sJy+7BNMJUom7/uWmDC6MntCCBV15rnSCaYqR
 Z8V5RZfioDe3M0I2nwd/yzK2FgLJQEg+p9v8/NPFUNkej+cgh8aTk3AR+/W0bBGf3L
 e/65ubd5IPsQ4NqaD5yn3CzK1WnYA6lY0BPQJ0yEO+qLVTohMamppJys2hmruVKvuY
 fLFmfX/LizRzruntnUvXHAl8LGv/Sbf6AqU/QBievmwugKAZ1eZkyS/JgQJno1ifIy
 qFfcmU11+EZXw==
Message-ID: <bd92f1f0-5702-4f0e-aadc-c956add276a9@kernel.org>
Date: Thu, 6 Aug 2026 10:43:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
References: <20260806014813.1587003-1-daeho43@gmail.com>
Content-Language: en-US
In-Reply-To: <20260806014813.1587003-1-daeho43@gmail.com>
X-Headers-End: 1wro4z-0002hw-Ss
Subject: Re: [f2fs-dev] [PATCH v7] f2fs: support dynamic reserve/release for
 device aliasing
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
Cc: Daeho Jeong <daehojeong@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 8/6/26 09:48, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> This patch adds a dynamic management feature to the existing device
> aliasing functionality. It allows users to dynamically reserve or
> release specific devices from the filesystem's free pool at runtime
> through new ioctls.
> 
> To support this, three new ioctls are introduced:
> - F2FS_IOC_RESERVE_DEV_ALIAS: This reclaims the space occupied by a
>   device aliasing file. It first performs a capacity check, resets GC
>   victim information for the target range, marks the segments as in-use
>   to prevent new allocations, and then triggers GC to migrate existing
>   valid data out of the range. Finally, it reserves these blocks in the
>   SIT to effectively exclude the device from the usable capacity.
> 
> - F2FS_IOC_RELEASE_DEV_ALIAS: This releases the reserved space of a
>   previously reserved device aliasing file. It truncates the blocks
>   associated with the file, which makes them available for general
>   filesystem allocation again.
> 
> - F2FS_IOC_GET_DEV_ALIAS_STATUS: This retrieves the current aliasing
>   status of a device aliasing file, returning whether the file is
>   released (inactive alias) or reserved (active alias, with blocks
>   fully allocated on the device).
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>
Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
