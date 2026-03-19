Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9DB81090223
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 19 Mar 2026 13:21:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:From:References:To:MIME-Version:Date:Message-ID:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZQFXIW3dTrsMBYBzdRo8ALVBNGvz+JItJj1pqmVf4iI=; b=V/H07ZpGgV9YgRtgjU7AGXiIw9
	2zoSC8nKz89xXiuiQfQxCnibYdGDCNJPsa8T8tGxpOY2cGDr5nC81yWibfgNSqiDJPBl/bdiT6duF
	ZH3PmUTwa9DE8olHv3i1WtClkHRi7apyvUKGUjByoQSfpsRpaG8q/lfgQevyfKAaW+c0=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1w3DJ5-0005FN-SM;
	Thu, 19 Mar 2026 13:20:59 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <monty_pavel@sina.com>) id 1w3DIt-0005F5-4y
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 19 Mar 2026 13:20:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Y/g2HVK/Agn1FZI6vrSA4fMqJowzNLFnDNSxmfKcK4o=; b=jrO5xQZ0corvQolw5kfJgIoh/A
 byVxIZKrQUEzMhXS3kstf4nwDX0rUUN6WuqiB21gkA10r5++9CGXhR0KoHd+2uOatFHkToo8nyVWB
 sQ7pqtHujdFmqaN61OXKSSmTXWZfZznClYwrLIX7MabYl9lKuN+oZvijjBL4MZcrWcqA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Y/g2HVK/Agn1FZI6vrSA4fMqJowzNLFnDNSxmfKcK4o=; b=T2Nt2ytnsb5+zp3JVxO/hVi41K
 aZTK4c6IS4QiBwhnDppu6LsvqdNiYWP91+d6QDThes+3kQ/9Ph6AhUl26QzCYxF36bx/ZcW3uHKop
 +sAozAFr3Ia4v52wi4oOD++yFod9IWco+w0IRhIq8pLXWdWOacfT0HVIA35vcE3t4VdA=;
Received: from mail3-163.sinamail.sina.com.cn ([202.108.3.163])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1w3DIs-00073d-2t for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 19 Mar 2026 13:20:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208;
 t=1773926446; bh=Y/g2HVK/Agn1FZI6vrSA4fMqJowzNLFnDNSxmfKcK4o=;
 h=Message-ID:Date:Subject:From;
 b=ggcd909lu6fa2qtITuktxyhgxdAwhxzj4ePJkclH6tXdgXqgUS0sV2IUiLPI7gFwj
 5LkX/ONJTg43idpSvIOOPSMGyg2smsJfspm4XYuMMOGedtFchjrsGM4dsOx5W5O31/
 VAXl1wc1UTrQ+Cf/nTMz6+v+QZ3neNsnhw1lbvYg=
X-SMAIL-HELO: [10.189.138.37]
Received: from unknown (HELO [10.189.138.37])([114.247.175.249])
 by sina.com (10.54.253.34) with ESMTP
 id 69BBF81F000050EF; Thu, 19 Mar 2026 21:20:33 +0800 (CST)
X-Sender: monty_pavel@sina.com
X-Auth-ID: monty_pavel@sina.com
Authentication-Results: sina.com; spf=none smtp.mailfrom=monty_pavel@sina.com;
 dkim=none header.i=none;
 dmarc=none action=none header.from=monty_pavel@sina.com
X-SMAIL-MID: 2307356291731
X-SMAIL-UIID: C5BE4B8A519D46349F5FE4B8DE20D131-20260319-212033-1
Message-ID: <f10a3cbd-7d5e-45b2-8ebb-672eddeb1f14@sina.com>
Date: Thu, 19 Mar 2026 21:20:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Chao Yu <chao@kernel.org>, Jaegeuk Kim <jaegeuk@kernel.org>
References: <20260319083417.603605-2-monty_pavel@sina.com>
 <db3014c0-2e56-4c3f-8a63-2c335aafbebb@kernel.org>
Content-Language: en-US
From: Yongpeng Yang <monty_pavel@sina.com>
In-Reply-To: <db3014c0-2e56-4c3f-8a63-2c335aafbebb@kernel.org>
X-Headers-End: 1w3DIs-00073d-2t
Subject: Re: [f2fs-dev] [PATCH v2 1/2] f2fs: fix incorrect multidevice info
 in trace_f2fs_map_blocks()
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
Cc: Yongpeng Yang <yangyongpeng@xiaomi.com>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 3/19/26 19:06, Chao Yu via Linux-f2fs-devel wrote:
> On 2026/3/19 16:34, Yongpeng Yang wrote:
>> From: Yongpeng Yang <yangyongpeng@xiaomi.com>
>>
>> When f2fs_map_blocks()->f2fs_map_blocks_cached() hits the read extent
>> cache, map->m_multidev_dio is not updated, which leads to incorrect
>> multidevice information being reported by trace_f2fs_map_blocks().
>>
>> This patch updates map->m_multidev_dio in f2fs_map_blocks_cached() when
>> the read extent cache is hit.
>>
>> Signed-off-by: Yongpeng Yang <yangyongpeng@xiaomi.com>
> 
> Needs a Fixes line and CC stalbe tag?

OK, I'll add Fixes line in v3 patch.

Thanks
Yongpeng,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
