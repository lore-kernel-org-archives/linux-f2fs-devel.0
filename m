Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 111AFC982D8
	for <linux-f2fs-devel@archiver.kernel.org>; Sun, 20 Sep 2026 15:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=16IRw+RhSkZQJZwdZPQIgVSq7vDhia5ui0fAYx7uYKA=; b=aB9PMhdgkTO3DXTZ7mlNz2giSz
	MWTSCbWXuKnkp51ua+DSviHAA76ufaqd6YM0cywTpwatS/NwJqAU6Hu1HO44ygSTTy1Qs4I4XirOD
	4jVZD/6l9xM+1HTrUnThx2Iv+XfJL+KsU4oeQZ4VfZi39NWyr1V1Usi+igRbQyUqV3k4=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x8Jdh-0005bw-Im;
	Sun, 20 Sep 2026 15:39:37 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <asj@kernel.org>) id 1x8Jdg-0005bq-6D
 for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 20 Sep 2026 15:39:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=cv3upVLlLJS+6kXvAxKeIkkhG/o5kn6HrkMar9tjczM=; b=J2SZEaITldsINBxw8do+xtUgBm
 UPowpSZK7JYiKBErfj9lN0y9ziLUcMJW+UQO3+ahQm3Zte0DHrop/E68lALmNp81C8QRmFXfEal5Y
 +LBYbDtWXyraiqVTuAy2Ao9Zyu5+W63H6ydc+cFvYeHTrvVDYVmsgVa4yDLHQtrEkJNg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=cv3upVLlLJS+6kXvAxKeIkkhG/o5kn6HrkMar9tjczM=; b=WACd3t2ppGr/2DMrpTnMn/kUuj
 yOnM3NJ6U//f+uGj3qSb/FyW6K9lI2BjZKO1EJWwYVFRbxgYaie9SvD09X+giRGIZe7WDBCZGEdLH
 1HUmgmN58EtejJP0vkzEAeMQoEfikJiWrsffly4IZD5FTNz8n4jt4NW4qh6NaR/a9DKo=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x8Jdf-0000zu-Lq for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 20 Sep 2026 15:39:36 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 02992601F0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sun, 20 Sep 2026 15:39:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CEA91F000FF;
 Sun, 20 Sep 2026 15:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789918768;
 bh=cv3upVLlLJS+6kXvAxKeIkkhG/o5kn6HrkMar9tjczM=;
 h=Date:Subject:To:References:From:In-Reply-To;
 b=jYJ3ldXFu9CC6bfen7zLfFY7Aa5jpQes/sdMVcUZBLuoHmoynBUH0e1sdEZY0i0bQ
 Zjf9ntu8pp5NVcV7DfWhYW8ZjDDe8/zFtECFjrBmKRnXb7yhGfLoiYj6nrCMpsGaCf
 gaQ7LbgHCkd3KZgzOxhwXLPxAv4jNCI5aYPlySyv0DjSP7H0HMFhQzx3vkxSms9P6H
 M/OwcBq8zEf7D/dlXacq/lG0IsDMb8oQgzhQEb1hfpep7HqrN3QzV/Vj42HjOI3aRk
 eBOH/IMPoFdFSSQ81SKpzL7dftlSi2F94tET29QHVfteWqBUcBw4NHglEwwRZiaiIs
 E7JuUf+DFeIdg==
Message-ID: <124a503d-14c4-48ea-af4c-692cb59fe3aa@kernel.org>
Date: Sun, 20 Sep 2026 23:39:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: fstests@vger.kernel.org, linux-btrfs@vger.kernel.org,
 linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, djwong@kernel.org
References: <cover.1784949154.git.asj@kernel.org>
 <8d69567fb5700c5a4075509bd7272d02ce9ba4f5.1784949155.git.asj@kernel.org>
 <apc6wRjPnQZNYfxV@zlang-mailbox>
Content-Language: en-US
In-Reply-To: <apc6wRjPnQZNYfxV@zlang-mailbox>
X-Headers-End: 1x8Jdf-0000zu-Lq
Subject: Re: [f2fs-dev] [PATCH v8 12/13] fstests: add _change_metadata_uuid
 helper
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2/9/26 04:53, Zorro Lang wrote:
> On Sat, Jul 25, 2026 at 03:39:09PM +0800, Anand Jain wrote:
>> _change_metadata_uuid changes the UUID of the golden filesystem before it
>> is cloned.
>>
>> Signed-off-by: Anand Jain <asj@kernel.org>
>> ---
>>  common/rc | 23 +++++++++++++++++++++++
>>  1 file changed, 23 insertions(+)
>>
>> diff --git a/common/rc b/common/rc
>> index f73251365a60..45cf9360ba73 100644
>> --- a/common/rc
>> +++ b/common/rc
>> @@ -1533,6 +1533,29 @@ _scratch_resvblks()
>>  	esac
>>  }
>>  
>> +# Change the metadata UUID of the given device to a newly generated one.
>> +# Args:
>> +#   $1: Block device path to modify.
>> +_change_metadata_uuid()
>> +{
>> +	local temp_mnt=$TEST_DIR/${seq}_mnt
>> +	local dev=$1
>> +


>> +	case $FSTYP in
>> +	xfs)
>> +		_require_command "$XFS_ADMIN_PROG" "xfs_admin"
>> +		$XFS_ADMIN_PROG -U generate $dev >> $seqres.full
>> +		;;
>> +	btrfs)
>> +		_require_command "$BTRFS_TUNE_PROG" "btrfstune"
> 
> How about split this function to _require_metadata_uuid_tool and
> _chanage_metadata_uuid ?

Splitting out _require_metadata_uuid_tool() is more modular, but I'm not
sure it's needed until we have multiple callers. With only a single
caller, an extra helper feels unnecessary. Inlining it makes the flow
easier to read and execute. Similar to how we handle this in the kernel.

Thanks, Anand


> 
>> +		$BTRFS_TUNE_PROG -m $dev
>> +		;;
>> +	*)
>> +		_notrun "Require filesystem with metadata_uuid feature"
>> +		;;
>> +	esac
>> +}
>> +
>>  # Create a small loop image, run an optional tuning function ($2) on it,
>>  # clone it, and attach both to loop devices, returned in ($1).
>>  # Args:
>> -- 
>> 2.43.0
>>



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
