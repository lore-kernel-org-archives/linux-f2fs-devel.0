Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FAAFC4452B
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 21 Jul 2026 22:38:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=czlcdAPPckCv4yhFN7d/DzZq3/91pPeBAmmgwOB93Qg=; b=bn5x/UXj0zg/tHdi/f28n/knHt
	j0UwhCy9fjBh+mgPslsXEyXpd140QHUQn4sb5GRiuPwQ2idpSILHOUPYy8bHLpnWtKOZSbC29H2bk
	bB9WH1ABMHV+OJg9o4I72Ti05K1C4ST5ruizPhxUg7DvHXozCeRHkVLIweVkwCXkdpMY=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wmJ6b-00036Q-Vq;
	Tue, 21 Jul 2026 22:38:30 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <asj@kernel.org>) id 1wmJ6b-00036G-37
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 21 Jul 2026 22:38:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 References:Cc:To:Subject:From:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=WDmDZTIDZNcAFuhGz8dTh3etu6wdnO4DjLK0ii8Wyzk=; b=UwS155NGn0iZ7QPtCjf33SyWCQ
 p09Fe3FYjfNXY3Etdvy2UBtFfkEZFAt81P/fBQW44D5HEcv3TJIJpAfg35EUlqCd57fYDb1kPhpd0
 Ev7OFSoz3mewbihF/Yw5vqdg1RQimZeoTiAgfwKrYFByQZn0dB2Mz57GaCxWqj54MxaE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Cc:To:
 Subject:From:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=WDmDZTIDZNcAFuhGz8dTh3etu6wdnO4DjLK0ii8Wyzk=; b=e7r/I322oTsH9/u2V6hzkLZzt3
 9AYZeMawb9EyTudzbDPGZrkztC4qcaOHFHsWmw5yw9JtPj4coEFL3F9XJGFMfKU3iRkjbK7VSEZuC
 EdgfCbyTHNjftnrUlLpZg5lOjLxr+mLPKYlxzE6Bl9di0JNeiE0jHXpsCwkJ0BGsOE4w=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wmJ6b-0003oN-AD for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 21 Jul 2026 22:38:29 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 97A1660A6E;
 Tue, 21 Jul 2026 22:38:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F3901F00A3F;
 Tue, 21 Jul 2026 22:38:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784673498;
 bh=WDmDZTIDZNcAFuhGz8dTh3etu6wdnO4DjLK0ii8Wyzk=;
 h=Date:From:Subject:To:Cc:References:In-Reply-To;
 b=ARtcLoJzABGhjsRsl43Z8c5OfbhrPDdPrGHmNzke9lhWPAi769ClK25YbAUsSPM46
 G68nyYdRIURws4B22ZoP0ftvrwtCLv0Nr0u0ktF07WWJAoZJ19gDfGo3Aq9g6Qkuyp
 6rm0XRu3Uz0j1XrFVqGmYCXluJ6rc9RoSX8cUZmNLQ4ZdofPeM11yD3BW4I/99lde3
 U+eANkIjik5L4lDFo6QF9pWBHXqcOETMLerNDP3pqLMN+ZVhekwVlYuHbgfsOTfrM6
 yUW+a5us7kufuQxLLcrjn2DCFKpHpuoVM0z7HXQE8X4G7ZD8ocT7oFG2whgGepucM9
 1oIO9UA681Zvg==
Message-ID: <10f50eff-3d65-4e58-af4c-977e786617b8@kernel.org>
Date: Wed, 22 Jul 2026 06:38:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: "Darrick J. Wong" <djwong@kernel.org>, Anand Jain <asj@kernel.org>
References: <cover.1781694879.git.asj@kernel.org>
 <421c7cdd5aae27b99d04dddf08c5d9df79c2f790.1781694879.git.asj@kernel.org>
 <20260701170713.GE6517@frogsfrogsfrogs>
Content-Language: en-US
In-Reply-To: <20260701170713.GE6517@frogsfrogsfrogs>
X-Headers-End: 1wmJ6b-0003oN-AD
Subject: Re: [f2fs-dev] [PATCH v7 01/11] fstests: add
 _loop_image_create_clone() helper
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
Cc: hch@infradead.org, zlang@redhat.com, fstests@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
 linux-ext4@vger.kernel.org, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net


>> +		_mkfs_dev "-s size=4096" ${loop_devs[0]}
> 
> Not sure why you pass two separate cli arguments as a quoted string, but
> my guess is it "doesn't matter" because _try_mkfs_dev uses $* unquoted,
> which separates them again.
> 
> I HATE BASH.
>> +		;;
>> +	btrfs)
>> +		_mkfs_dev ${loop_devs[0]}
> 
> And while I'm whining:    ^^^^^^^^^^^^^^^ actually should be quoted.
> Not that fstests is at all good at getting this right.
> 

Damn! Fixed the two issues above.

>> +		;;
>> +	*)
>> +		_mkfs_dev ${loop_devs[0]}
>> +		;;
>> +	esac
>> +
>> +	# Only execute if the function argument is not empty
>> +	if [ -n "$pre_clone_tune_func" ]; then
>> +		$pre_clone_tune_func ${loop_devs[0]}
>> +	fi
>> +
>> +	sync ${loop_devs[0]}
>> +	cp $img_file $img_file_clone
> 
> What if cp doesn't create a reflink copy?  Can we fill up the $TEST_DIR
> despite having checked it for sufficient free space?  Especially on
> filesystems that don't support sparse holes?
> 

We have _require_fs_space a few lines above (yes, I have doubled the
size requirement). If we reach this point, cp is unlikely to fail, but
if it does, it will be messy.

        _require_fs_space $TEST_DIR $((size * 1024 * 2))

Added a call to _fail to be more direct.

        cp $img_file $img_file_clone || _fail "Failed to copy cloned image"



>> +
>> +	loop_devs="$loop_devs $(_create_loop_device $img_file_clone)"
>> +
>> +	_ret=($loop_devs)
> 
> Hmm.  Should this function return nonzero if any part of the clone
> creation fails?  Or are callers expected to notice that _ret only has
> one element?
> 

If we are here, both images have been created successfully; otherwise,
we would have called _fail.

> --D

Thanks for the reviews Darrick.
-Anand



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
