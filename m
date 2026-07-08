Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D810FC43602
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  8 Jul 2026 03:25:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4+QBZe8DRKf/Nc4C9+fqePRXyLaNslHtPlIYIgyxZlc=; b=jh5sUqXU82QmEtEVpZ+TdzU4S4
	FkrLxBZm28fgF9m8hxZrJ0V46YBoT5AtbQG/EXhraqYYuK3aQqpTqkPSRMre4BRpddReFC4LKEpxp
	ubqicIimXYhRCsSve/X86zkLjz/m1UTzpMdB2RWbtRdZVxLMTaiWun9WbThanhkte4iQ=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1whIv1-00049e-RG;
	Wed, 08 Jul 2026 03:25:52 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1whIv1-00049T-1R
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 08 Jul 2026 03:25:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=hS1cvogx7rmILOdwa1cOexvAFCvVtvKKnqus3HvfByw=; b=UZ3iL9DOaqS5fqTwHv8ApFtOLC
 07iT1wRlJ5+E/sFiGo//GM1d9EUcAC5Xmo2vXUPEBI3Zsk0YE+pOpETz0KvCvcdGarlKYHGGgEve/
 CmtNqhgTVOkqbK5qNa+CnkT20CzkgSXK/hLVuPu2k/tiOP+pzOCYxion/txrDbIQNvEk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=hS1cvogx7rmILOdwa1cOexvAFCvVtvKKnqus3HvfByw=; b=AaexLQ50P0sjNVWeNAtv/lKs/l
 jSl+ZlTiXwiftjIyAWLFi6U+IbxpMhD9QaWuFCFM1bwU9Gs5OVeu0L3ol05OcgIHRq3rNMcZCleic
 isd913wqfQtqgzWBQTdghoDVh5Csh3UlRFi4yZg4EzdBTyaAwPGqMMzzx6X3ZMdc8yag=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1whIv1-0007cH-DV for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 08 Jul 2026 03:25:51 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 188E4412C8
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed,  8 Jul 2026 03:25:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 948AD1F000E9;
 Wed,  8 Jul 2026 03:25:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783481141;
 bh=hS1cvogx7rmILOdwa1cOexvAFCvVtvKKnqus3HvfByw=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=BI7eLc+ZrbpuF80zxsU9KNd530lWC/Uv25SPLwojj/9MWVyfmwneOgA37a9oDh0Ot
 a5pbtzf7XYlrCj2lDc+bvK/YJbSuceDfrBNH6pTgg+pLccaI7OrPoaeZkOKhUqIdFP
 dEujKCShU5k9bVpWc36WqxSIbxBrKZpri9hXOYr3iG8gV1nRjIn7ex96VyznzEa8aG
 dkX5hNHOqR3wniPiS0d2eJu2OnJZh2dmNrr6NjmLPYzlQaLv1CDW/71oec7u1g28Az
 tRVTRAd2lxqZfNF8B695TPef4IKoEKZtblOm9N+Zqrcdq8RprHGPYl3atrumR1jQLS
 QQIFd52cTw/tg==
Message-ID: <5c11cd98-bb41-46e0-9765-e2aad57a08e4@kernel.org>
Date: Wed, 8 Jul 2026 11:25:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Anand Suveer Jain <asj@kernel.org>, Zorro Lang <zlang@kernel.org>,
 fstests@vger.kernel.org
References: <20260706064326.3657995-1-chao@kernel.org>
 <af5f0eb1-0197-4952-a37b-0602799929ec@kernel.org>
Content-Language: en-US
In-Reply-To: <af5f0eb1-0197-4952-a37b-0602799929ec@kernel.org>
X-Headers-End: 1whIv1-0007cH-DV
Subject: Re: [f2fs-dev] [PATCH v2] common/rc: support f2fs in
 _require_fanotify_ioerrors()
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
Cc: jaegeuk@kernel.org, "Darrick J. Wong" <djwong@kernel.org>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 7/7/26 18:13, Anand Suveer Jain wrote:
> On 6/7/26 14:43, Chao Yu wrote:
>> f2fs has supported to report fserror, this patch adds support for f2fs
>> in _require_fanotify_ioerrors(), so that we can run generic/791 on f2fs.
>>
>> Cc: Darrick J. Wong <djwong@kernel.org>
>> Signed-off-by: Chao Yu <chao@kernel.org>
>> ---
>>  common/rc | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/common/rc b/common/rc
>> index 494725547..f51ad59f3 100644
>> --- a/common/rc
>> +++ b/common/rc
>> @@ -6257,6 +6257,9 @@ _require_fanotify_ioerrors()
>>  		x="$(_get_fs_sysfs_attr $TEST_DEV err_report_sec)"
>>  		test -n "$x" && return 0
>>  		;;
> 
> 
>> +	f2fs)
>> +		x="$(cat /sys/fs/f2fs/features/fserror)"
>> +		test -n "$x" && return 0
> 
> Don't we need to check if /sys/fs/f2fs/features/fserror
> is present in the running kernel (there are helpers)

Hi Anand,

You mean _has_fs_sysfs_attr()? however, it forces to check first parameter $dev
w/ block device type:

	if [ ! -b "$dev" -o -z "$attr" ];then
		_fail "Usage: _has_fs_sysfs_attr <mounted_device> <attr>"
	fi


> before reading it?

How about this?

f2fs)
    local feat_file="/sys/fs/f2fs/features/fserror"
    if [ -f "$feat_file" ] && [ "$(cat "$feat_file")" = "supported" ]; then
        return 0
    fi
    ;;

> 
> 
> 
>>  	esac
>>  
>>  	_notrun "$FSTYP does not support fanotify ioerrors"
> 



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
