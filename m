Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81BDAC61DF4
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 24 Nov 2023 15:23:05 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1r6Y1H-0007Up-AL;
	Fri, 24 Nov 2023 15:23:03 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <gabriel@krisman.be>) id 1r6Y1F-0007UX-Tx
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 24 Nov 2023 15:23:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:MIME-Version:Message-ID:Date:
 References:In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=nFFFOKyC6p1FOoorSMK24kJ5FMkPhQFR5RZw96Asog4=; b=c0dFKeuUh8UI8sHFz+LNJGLaHU
 lnrirUoZt+pUSkbXF3VflOneJPOBMeOa8v0EojWtpR5ForfKzorJxjJ2BTi/6+X/gj0Qr2EHZYkSl
 hmPivICmM1zbmwqok77R0RriswUF1g4qrVt0wRRZbJlT5o3XEN1AJ/S8JR6hEr9PGtY4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:MIME-Version:Message-ID:Date:References:In-Reply-To:Subject:
 Cc:To:From:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=nFFFOKyC6p1FOoorSMK24kJ5FMkPhQFR5RZw96Asog4=; b=igaO5AwHDV5mDnkWWHcjc9PelV
 HdcWmhChw2EYYJRrRzXjN5ivfIh9Un4dtCuzyEWtj2s11HmeAASO+VL3lQpQ5bcp4vyhlUxFbzaA1
 kMeb9mHZGvqE79LSFjdXirDLU0HRuaMGhGnLTSactB/GumV6URpm8fHX+BtAlgHzfocI=;
Received: from relay8-d.mail.gandi.net ([217.70.183.201])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1r6Y1F-00EORu-Cv for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 24 Nov 2023 15:23:02 +0000
Received: by mail.gandi.net (Postfix) with ESMTPSA id CE7E01BF20A;
 Fri, 24 Nov 2023 15:22:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=krisman.be; s=gm1;
 t=1700839372;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nFFFOKyC6p1FOoorSMK24kJ5FMkPhQFR5RZw96Asog4=;
 b=h0ksV85mHyER9weo51zXH0+I93eoVv8zic3Pep0xMnyIbVAGPMf8AlKmlRLpNMJzFlrcrF
 RK0X2S9Oz2IAHSAQCVXQ9hdbbZCYgc9SYGyi7hLfEI8vXnWzjKzIfH1TjNvxCLuXogY37N
 KwsOh/9JwZqXgCZyxj1OMJMvZKF26j9D/Hj0noHzPFe1ytsYN9uLegU6C5eyEQIgjoMwEq
 tPBGRtY3VNzX2iz2xKh9bN26J8RiSsv491w/JQGDrqq21jf/9t1eRNOnN/wZAWT2odpy33
 6DvZwXZehQsTnLH6w8fWvtm0VMdJQtwecNRgazkr0EH2pZMYGADavZ1C6sBIZA==
From: Gabriel Krisman Bertazi <gabriel@krisman.be>
To: Al Viro <viro@zeniv.linux.org.uk>
In-Reply-To: <20231123215234.GQ38156@ZenIV> (Al Viro's message of "Thu, 23 Nov
 2023 21:52:34 +0000")
References: <20231025-selektiert-leibarzt-5d0070d85d93@brauner>
 <655a9634.630a0220.d50d7.5063SMTPIN_ADDED_BROKEN@mx.google.com>
 <20231120-nihilismus-verehren-f2b932b799e0@brauner>
 <CAHk-=whTCWwfmSzv3uVLN286_WZ6coN-GNw=4DWja7NZzp5ytg@mail.gmail.com>
 <20231121022734.GC38156@ZenIV> <20231122211901.GJ38156@ZenIV>
 <CAHk-=wh5WYPN7BLSUjUr_VBsPTxHOcMHo1gOH2P4+5NuXAsCKA@mail.gmail.com>
 <20231123171255.GN38156@ZenIV> <20231123182426.GO38156@ZenIV>
 <20231123215234.GQ38156@ZenIV>
Date: Fri, 24 Nov 2023 10:22:49 -0500
Message-ID: <87leangoqe.fsf@>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
X-GND-Sasl: gabriel@krisman.be
X-Headers-End: 1r6Y1F-00EORu-Cv
Subject: Re: [f2fs-dev] [PATCH v6 0/9] Support negative dentries on
 case-insensitive ext4 and f2fs
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
Cc: Christian Brauner <brauner@kernel.org>, tytso@mit.edu,
 linux-f2fs-devel@lists.sourceforge.net, ebiggers@kernel.org,
 linux-fsdevel@vger.kernel.org, jaegeuk@kernel.org, linux-ext4@vger.kernel.org,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Gabriel Krisman Bertazi <gabriel@krisman.be>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Al Viro <viro@zeniv.linux.org.uk> writes:

> On Thu, Nov 23, 2023 at 02:06:39PM -0500, Gabriel Krisman Bertazi wrote:
>
>> >
>> > 4. d_move() and d_exchange() would ignore the value returned by __d_move();
>> > __d_unalias() turn
>> >         __d_move(alias, dentry, false);
>> > 	ret = 0;
>> > into
>> > 	ret = __d_move(alias, dentry, Splice);
>> > d_splice_alias() turn
>> > 				__d_move(new, dentry, false);
>> > 				write_sequnlock(&rename_lock);
>> > into
>> > 				err = __d_move(new, dentry, Splice);
>> > 				write_sequnlock(&rename_lock);
>> > 				if (unlikely(err)) {
>> > 					dput(new);
>> > 					new = ERR_PTR(err);
>> > 				}
>> > (actually, dput()-on-error part would be common to all 3 branches
>> > in there, so it would probably get pulled out of that if-else if-else).
>> >
>> > I can cook a patch doing that (and convert the obvious beneficiaries already
>> > in the tree to it) and throw it into dcache branch - just need to massage
>> > the series in there for repost...
>> 
>> if you can write that, I'll definitely appreciate it. It will surely
>> take me much longer to figure it out myself.
>
> Speaking of other stuff in the series - passing the expected name to
> ->d_revalidate() is definitely the right thing to do, for a lot of
> other reasons.  We do have ->d_name UAF issues in ->d_revalidate()
> instances, and that allows to solve them nicely.
>
> It's self-contained (your 2/9 and 3/9), so I'm going to grab that
> into a never-rebased branch, just to be able to base the followups
> propagating the use of stable name into instances.

ack. I'll base the other changes we discussed on top of your branch.

thanks,

-- 
Gabriel Krisman Bertazi


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
