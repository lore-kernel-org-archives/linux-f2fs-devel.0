Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70AADC61DD3
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  1 Sep 2026 22:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PQ5yEK6mDkFJJz9UnahZjGcdsEK5j3pGK7aTztsEEus=; b=UztbNvwl6O+RihsjtEt9hdFLiN
	iQmxU6SZW2gXPkHfs17eORn8oJcEoVAGmLZahzn3w82GPwTHTocjoENEz/4Hku8HQ3/IH97ygCOab
	3kxgEHINjqdBTFPU0cCUcaclC3xGwMUvwOuoLZtidbH38FPOVQ19AUfgRq4Wp6YTSVAo=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x1X97-0002Q7-9Q;
	Tue, 01 Sep 2026 22:40:01 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <asj@kernel.org>) id 1x1X95-0002P9-UR
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 01 Sep 2026 22:39:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:Cc:References:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Y3GyRQmkNcYKTCnekW4yN3hnOUmTS5cdA7r1xqXY2rI=; b=Eqmba53QblLE60piRp0xcvc6eM
 rWvhsKqz2MVklx155eWXRQp8dbWujQL9emfB9K1yZL9NFnWbey47bLCU0Hn0KDTnkqHs6rfpCgsLn
 gDdXWhleQF1hqxk6cb5HT/DFAdH7zQe/wlYrW+xKzGiZubQzjIpK4YKeRVQ/+0+chvfQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:Cc:References:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Y3GyRQmkNcYKTCnekW4yN3hnOUmTS5cdA7r1xqXY2rI=; b=MLv9Mk+LxRwZHJJzg6qB3qbwVF
 RMoc/eJst+G8EWSvUpsgusNJDo2d4lGwiC3TX1VcHg+yNElIaK5aPvruwzIFnmnxdF9QPmJQx15Bp
 vIVmPGEEwiv5Y6Vmwm9Sh0O5ZE9TeqHYLfo1Z7HbMzzVwnd9iytlAx/PCjh3Qck9E0BQ=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x1X95-0006uK-Fl for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 01 Sep 2026 22:39:59 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id DE38241206
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue,  1 Sep 2026 22:39:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F00EC1F000E9;
 Tue,  1 Sep 2026 22:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788302393;
 bh=Y3GyRQmkNcYKTCnekW4yN3hnOUmTS5cdA7r1xqXY2rI=;
 h=Date:Subject:To:References:Cc:From:In-Reply-To;
 b=KxmKD2Js69YRZhBqZss88pSHzX8mF3Zs5PDYIT06m2QTQIpgC9JPfxSYoLf/bGmWp
 wRv9n1GL+wPf9L+lJ7Ipy+kZv6vdNYaEenr3uiERL6BSmBh3eRPB4psunwmEfIp420
 gozI7GqV9KqdHuUaFeAWOzgNCcX3i887v5XFjfZ8X/p1ed81vY/yUtq8ed3Te53RDw
 EGJXiLOE46vIpd10IPkFmm1hdY6OIqMW6fC1e+P8T+azC1DrYaGxKechrxXYa6I7ZH
 L501wuggBwq5pgj+SuUUQp3iX/Sn/CvNSuNg6uotHCIun4tiTspGI/n5kPMEQEEtMo
 YsraSJQWGldhw==
Message-ID: <ab106ce4-d8ce-4667-a73e-58a93504bea1@kernel.org>
Date: Wed, 2 Sep 2026 06:39:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Zorro Lang <zlang@kernel.org>
References: <cover.1784949154.git.asj@kernel.org>
 <d8fb7f5c0d67cf01249e8fc4807e963cc1a353d0.1784949155.git.asj@kernel.org>
 <apbxt_WcZOYfmfd9@zlang-mailbox>
Content-Language: en-US
In-Reply-To: <apbxt_WcZOYfmfd9@zlang-mailbox>
X-Headers-End: 1x1X95-0006uK-Fl
Subject: Re: [f2fs-dev] [PATCH v8 04/13] fstests: add
 _require_fanotify_function
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
From: Anand Suveer Jain via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Anand Suveer Jain <asj@kernel.org>
Cc: djwong@kernel.org, fstests@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
 linux-ext4@vger.kernel.org, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net



On 1/9/26 23:42, Zorro Lang wrote:
> On Sat, Jul 25, 2026 at 03:39:01PM +0800, Anand Jain wrote:
>> fanotify support may not be compiled into the kernel. Add
>> _require_fanotify_function to skip tests when fanotify is disabled.
>>
>> Signed-off-by: Anand Jain <asj@kernel.org>
>> ---
>>  common/rc | 7 +++++++
>>  1 file changed, 7 insertions(+)
>>
>> diff --git a/common/rc b/common/rc
>> index 53e5d9d43af6..21b516accdf7 100644
>> --- a/common/rc
>> +++ b/common/rc
>> @@ -6329,6 +6329,13 @@ _require_max_file_range_blocks()
>>  	esac
>>  }
>>  
>> +_require_fanotify_function()
>> +{
>> +        if $FSNOTIFYWAIT_PROG 2>&1 | grep -q "Function not implemented"; then
>> +                _notrun "Need CONFIG_FANOTIFY and CONFIG_FANOTIFY_ACCESS_PERMISSIONS to be enabled"
>> +        fi
> 
> What happens if $FSNOTIFYWAIT_PROG fails with an error other than
> 'Function not implemented'?

The known failure conditions, the availability of the fsnotifywait
userspace tool and the kernel configuration are checked.

For any other errors, the test case (generic/801) will fail
during monitor setup and log the error to stdout for debugging.

Thanks, Anand

> Thanks,
> Zorro
> 
>> +}
>> +
>>  _require_fanotify_ioerrors()
>>  {
>>  	local x
>> -- 
>> 2.43.0
>>



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
