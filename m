Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE831C61DD3
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  1 Sep 2026 23:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JIm3pJfgsLm4cibUJPW3Yj4UH5CzPDwzn3TaT7mm59o=; b=fPQYO74sSl9k6oTZi6QwNFXXNb
	ReAgW3gqbdWYJ2XOu5LPIAw9t+18XyazALE43EEoiK5my6wgH509U2WnFa8gAdXktXTBe+zws+Vgz
	9XpflSv5S/lKbe7nggTf5d00gIJiHOtatZHNQEwnsTZBmAST9g3RxpiCETYQSCdd2Aow=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x1Xy0-0003T9-4Z;
	Tue, 01 Sep 2026 23:32:33 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <asj@kernel.org>) id 1x1Xxy-0003T1-RI
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 01 Sep 2026 23:32:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:Cc:References:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=03+cdQH6OSkJOrqr1DanmXDylDD6Vi1Wng3BzGHUVu4=; b=WHxSe2BL4R7UP2C7LC9CGOijbZ
 4nOYxP4jBPQoiDW6ft7P4tcZIFt/6DuMkblcmmSU2yhjuXMKWmnp+4elDm7N1fhl2tgXLzKTjFjq+
 Jw6hfhckLIPGDJpUUnNxYahBowfjjylvcn4XcHlcbOtoaZEQqxE0pLlGP+MldfSah0ZE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:Cc:References:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=03+cdQH6OSkJOrqr1DanmXDylDD6Vi1Wng3BzGHUVu4=; b=bTtGaU4k7H3fBly+Vo0QhwGguk
 sTwZGJKtpD1tYWptITZxtJDWLP9W0+dqVdavZ01WEUQwFycrfcPS/kQBQu1zebVtWaiZonRnLPOaG
 vrmDwEBVvtV80NexhAGz6ZlaKAKeA1BJDxyvHxnLBTrWdxLOyH5aW57dgL8eO4bc16qs=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x1Xxv-0001Ig-K4 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 01 Sep 2026 23:32:32 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A2726600D0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue,  1 Sep 2026 23:32:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A14F31F000E9;
 Tue,  1 Sep 2026 23:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788305545;
 bh=03+cdQH6OSkJOrqr1DanmXDylDD6Vi1Wng3BzGHUVu4=;
 h=Date:Subject:To:References:Cc:From:In-Reply-To;
 b=FXGk34vkpiY0LoHcsYDs7HMl0oV93yvwYDiuF2nT/9etACREQSwVhUxOl0cN2bVMd
 w1iXNl1Yv599cQuFeWjal/+9Bx6NMi8iv0tkQGVe5wVylk/nYVUtldcb0nZWdkE6xp
 pLuEo/hN7UizSLQ7bX8hhTlZfBoTV7HvROpWOYPAoLGM5YCWYHIpseZYlS+MKLgaC7
 BHa4bmYha8Esgvfs5PPyOkM/Q6pm4FmijTJomkuWjVH8s8lUPevKbEevHUbIffU3Aq
 kPKpP9cG8sEQGyVBw78CwRGpDVAw6W0G95TNUzaHOsFM6VJqjrh0sAYYcKG2Ie0FeB
 e4y8zATwuKRmQ==
Message-ID: <9832242f-cc39-46f7-847b-70871e52a373@kernel.org>
Date: Wed, 2 Sep 2026 07:32:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Zorro Lang <zlang@kernel.org>
References: <cover.1784949154.git.asj@kernel.org>
 <878a21ea507cb955ed414072c82ab5e5493b8ae0.1784949155.git.asj@kernel.org>
 <apb19-FLJv9dRFDS@zlang-mailbox>
Content-Language: en-US
In-Reply-To: <apb19-FLJv9dRFDS@zlang-mailbox>
X-Headers-End: 1x1Xxv-0001Ig-K4
Subject: Re: [f2fs-dev] [PATCH v8 05/13] fstests: add
 _require_unique_f_fsid() helper
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



On 2/9/26 00:09, Zorro Lang wrote:
> On Sat, Jul 25, 2026 at 03:39:02PM +0800, Anand Jain wrote:
>> Add a helper to check if the target filesystem supports unique f_fsid
>> tracking across cloned or snapshot instances.
>>
>> Certain filesystems like XFS, Btrfs, and F2FS ensure unique f_fsid
>> identifiers per filesystem instance. However, Ext4 derives its f_fsid
>> directly from its superblock UUID, which leads to identical f_fsid
>> values on cloned images until the UUID is manually modified by userspace.
>>
>> Introduce _require_unique_f_fsid() to allow test cases requiring strict
>> f_fsid uniqueness to skip gracefully on unsupported filesystems.
>>
>> Signed-off-by: Anand Jain <asj@kernel.org>
>> ---
>>  common/rc | 27 +++++++++++++++++++++++++++
>>  1 file changed, 27 insertions(+)
>>
>> diff --git a/common/rc b/common/rc
>> index 21b516accdf7..f73251365a60 100644
>> --- a/common/rc
>> +++ b/common/rc
>> @@ -6356,6 +6356,33 @@ _require_fanotify_ioerrors()
>>  	_notrun "$FSTYP does not support fanotify ioerrors"
>>  }
>>  
>> +# Skip the test if the filesystem does not enforce unique f_fsids
>> +# natively. Checking this dynamically requires recreating a clone
>> +# layout, so we use a static lookup based on FSTYP.
>> +#
>> +# Across all filesystems, a UUID collision causes libblkid tools to return
>> +# non-deterministic device mappings. It is ultimately the responsibility
>> +# of the userspace utility or use-case to enforce uniqueness when a clone
>> +# diverges. For details, see mailing list thread discussions:
>> +#   Link: https://lore.kernel.org/linux-ext4/20260409131238.GC18443@macsyma-wired.lan/
>> +_require_unique_f_fsid()
>> +{
>> +	case "$FSTYP" in
>> +	ext*)
>> +		# Ext4 derives f_fsid from the superblock UUID, meaning
>> +		# clones share the same f_fsid until their UUIDs
>> +		# diverge.
>> +		_notrun "Target filesystem ($FSTYP) does not guarantee unique f_fsid on clones."
>> +		;;
>> +	*)
>> +		# Conversely, XFS, Btrfs, and F2FS ensure f_fsid remains
>> +		# unique per filesystem instance (often by deriving it
>> +		# from the UUID and underlying block device.)
>> +		;;
>> +	esac
> 

> I would prefer to let the experts of each filesystem confirm whether their
> fs guarantees a unique f_fsid.

Theoretically, whether f_fsid is unique per clone depends on
how it is derived. If it includes the device major:minor,
it provides a unique ID per clone.

Btrfs does it since commit
 c2a74ed0494c btrfs: derive f_fsid from on-disk fsid and dev_t

> How about switching this logic to an *allowlist*
> *(whitelist)* approach, where we _notrun by default and only allow filesystems
> that explicitly guarantee unique f_fsid support?
> 
>   case "$FSTYP" in
>   btrfs|xfs|f2fs)
>         ;;
>   *)
>         _notrun "Target filesystem ($FSTYP) does not guarantee unique f_fsid on clones."
>         ;;
>   esac

So _notrun() unless confirmed to have unique f_fsid for the cloned
filesystem. Works for me.

Thanks, Anand

> Thanks,
> Zorro
> 
>> +}
>> +
>> +
>>  # Computes a percentage of the available space in a filesystem and
>>  # returns that quantity in MB. The percentage must not contain a percent
>>  # sign ("%").
>> -- 
>> 2.43.0
>>



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
