Return-Path: <SRS0=8g9c=DC=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B294C4727C
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 25 Sep 2020 23:17:24 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C73112074B;
	Fri, 25 Sep 2020 23:17:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="ZbTi/cLD";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="MvZsGib5";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="sGBG9THc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C73112074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1kLwxv-0006Og-35; Fri, 25 Sep 2020 23:17:23 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <chao@kernel.org>) id 1kLwxu-0006OW-8w
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 25 Sep 2020 23:17:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:From:Cc:References:To:Subject:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Oyh25OuZvW0UMEw/2/qZc4PPTE7Vw5zNXswj7d0ZD08=; b=ZbTi/cLDxmaCQLMwLLJLegnVwj
 4SYsV/RnzxKX7mNi2CSZ0yHjJ5W35vJ8DsjHtQ2iSfdwT/8ldMPe0LNUVytWFMZb4LjNdr+4X5Bi0
 DDSGxizmASE/kx6lVIRH/esT1bwb+uVaCfb5+iHqH4wvfm8qj1msR06cPEtN/AxL7lYQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:
 Message-ID:From:Cc:References:To:Subject:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Oyh25OuZvW0UMEw/2/qZc4PPTE7Vw5zNXswj7d0ZD08=; b=MvZsGib5YOFv8L6YDRIjqMqfzi
 A2kGWZq8fHgwhP8a7j7bqBU//FjCqCqWqEDOR7F0NUE2Tf/6TKqZYejWyhhHfapJZ1tKoKHC1sRLW
 MeVeeKagCbzmUTG45jQOabLwAY1/HMrdZowbRo7lI8DaW9nJp73H/UTIFnlHtuiuZdeg=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1kLwxs-0066eq-AN
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 25 Sep 2020 23:17:22 +0000
Received: from [192.168.0.108] (unknown [49.65.245.23])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 71D042074B;
 Fri, 25 Sep 2020 23:17:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1601075834;
 bh=EbJfwvBeHXIYBXTTELse8un9TJ2c/bhePB4Xfufh4yI=;
 h=Subject:To:References:Cc:From:Date:In-Reply-To:From;
 b=sGBG9THcIeHUpPQzlCVRHKRzBldFa0OoegE5xBKJJDE09XngNv7EhKTWvzGyqXUJP
 SReJNDgIo2CBwnM1FFUKm9UpgaEZW/roKBqoHjNFHaB2AdddeTjFF6VPx0IbP0AgfT
 Trqfe2ACwHH/Wd3NfuSZIbJVEjuvWVL4XUac/Ki8=
To: Eric Biggers <ebiggers@kernel.org>, Chao Yu <yuchao0@huawei.com>
References: <000000000000f9f80905b01c7185@google.com>
 <eb03a5c9-eb77-eb91-e17f-8a3273aab7da@huawei.com>
 <20200925163819.GA3315208@gmail.com> <20200925164538.GB3315208@gmail.com>
From: Chao Yu <chao@kernel.org>
Message-ID: <36d3ddc1-e8d1-6d0e-c1ea-aff198740182@kernel.org>
Date: Sat, 26 Sep 2020 07:17:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20200925164538.GB3315208@gmail.com>
X-Headers-End: 1kLwxs-0066eq-AN
Subject: Re: [f2fs-dev] KMSAN: uninit-value in f2fs_lookup
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
Cc: syzbot <syzbot+0eac6f0bbd558fd866d7@syzkaller.appspotmail.com>,
 syzkaller-bugs@googlegroups.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, glider@google.com, jaegeuk@kernel.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2020-9-26 0:45, Eric Biggers wrote:
> On Fri, Sep 25, 2020 at 09:38:19AM -0700, Eric Biggers wrote:
>> On Fri, Sep 25, 2020 at 05:06:33PM +0800, Chao Yu wrote:
>>> Hi,
>>>
>>> I don't see any problem here, thanks for your report. :)
>>>
>>> Thanks,
>>
>> What about if max_depth == 0 in __f2fs_find_entry()?  Then __f2fs_find_entry()
>> would return NULL without initializing *res_page.
>
> ... and I now see Dan Carpenter already pointed this out.  I was a bit late!

Thanks for your check as well. :)

Thanks,

>
> - Eric
>


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
