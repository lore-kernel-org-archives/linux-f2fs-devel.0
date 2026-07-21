Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75165C4452B
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 21 Jul 2026 23:21:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5QMO/szyFNacz5wX5jlhSVyMZSduq5gu5oKpJnt3Zko=; b=EOzQ48KlwjrhtSzQ5GriNZP7Bo
	2QUjH2kGVsVj4nf5yeiMtdUQiP3A+pZorWp+RdETlatY3o1FEfuP3ytq7uz6GotA4ZeqWMlCzj7IO
	bgmnX+ygcCYjEbA9cMww4X/WnZ8FZp0rkfoHawsm63B9s6tXAmmvDo9IQMg2ahdUFdNA=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wmJmA-0006ie-AO;
	Tue, 21 Jul 2026 23:21:27 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <asj@kernel.org>) id 1wmJm8-0006iX-RZ
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 21 Jul 2026 23:21:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=73WfWUSvjW6xW9PAg9sUSImOvdQUpt4d8xftqMCXXKw=; b=Abxvqe4V/G8HJIFKk6QARFSdUP
 JzSC6PxJWG+i1aBUQ+q21G8TXoRUkkM1SnuYoEBAGUHh0asfmNaRFwIlYygdpQHzK+srmdQfx6LF/
 45jPS8g7Z9CmP6syWdi8bEuyfTnqbSCcV2I2NuFUzddktz1UnqEBW6mzm5w/D9ZgdWrY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=73WfWUSvjW6xW9PAg9sUSImOvdQUpt4d8xftqMCXXKw=; b=ADMG1d/v49Ay8SEBQ+1IbqceEK
 z7U6QjmavgUBRiTNDw+6f6zq2WmjiyP/oO0JUbRJvK7P0x9bu33RuhjAEMRT2Q1nFl2SNG92sNn0b
 31HQPLX9rJpCqMXEuQS69QeaanN45Sx2ANA98ruH0WzbT6Bpz1kFMNb9hezox0U0ULIc=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wmJm9-0005Tr-0Y for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 21 Jul 2026 23:21:25 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5B29B600D8;
 Tue, 21 Jul 2026 23:21:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 785C31F000E9;
 Tue, 21 Jul 2026 23:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784676079;
 bh=73WfWUSvjW6xW9PAg9sUSImOvdQUpt4d8xftqMCXXKw=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=If+xVjPSe8sYvTjtWw7yXmNRrFVTXLA1mqvOdcLJmbh6fRpE9UVxcw6BqYLQWpZFB
 zllcimaBn5wDsxVCAD6fAlhKO4ImnJUipNtNLYCV+tZ4Mt0igW5QB965d+n/4LbjI4
 DZeMyqxya6Z+iBLHdpXRjyXWWX27PvjqFdT4NyREjCO/RfrdFe4crnMNOD8o89juLp
 YbOj2KaC1Qd95fGGwblRV8rNKYkmq/2I4pL9ksR/Cx+jxh6PeHIfzl/Eoq2SO3P7hi
 cOUVKALJ8rk6KklJGW4FIdid17qd0opO1oHEaFNKNByX4Gw+prQp2uJixt1vXeYR0x
 1FZOGjx4515zA==
Message-ID: <18d569b9-dbea-448c-8b3d-56de32c0d6ef@kernel.org>
Date: Wed, 22 Jul 2026 07:21:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: "Darrick J. Wong" <djwong@kernel.org>
References: <cover.1781694879.git.asj@kernel.org>
 <2ac5fb22fd6b51973d11082a1ee8fe354926c63c.1781694879.git.asj@kernel.org>
 <20260701173314.GH6517@frogsfrogsfrogs>
 <328de723-6f9c-4f09-a68a-da24d49300d5@kernel.org>
 <20260721225703.GZ7380@frogsfrogsfrogs>
Content-Language: en-US
In-Reply-To: <20260721225703.GZ7380@frogsfrogsfrogs>
X-Headers-End: 1wmJm9-0005Tr-0Y
Subject: Re: [f2fs-dev] [PATCH v7 06/11] fstests: verify f_fsid for cloned
 filesystems
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



>>> just in case there *are* programs foolish enough to
>>> use (fsid,ino) as a uniqueness check.
>>
>> On the other hand, if a program needs a unique ID, do we currently have
>> any way to get one?
> 
> I don't think there is a way to get a globally unique identifier for a
> filesystem image except for the meta_uuid filesystems, and even then
> only if the volume manager resets the user-visible uuid every time it
> makes a clone and nobody runs a duplicator.

Yeah, interesting problem to solve though.
Do you have any further code review comments on this test case?

Thanks.


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
