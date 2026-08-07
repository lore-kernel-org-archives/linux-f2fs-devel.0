Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1EBEC5AC80
	for <linux-f2fs-devel@archiver.kernel.org>; Fri,  7 Aug 2026 19:53:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5DOGVkfdn2gliKuUq5SbAnODx4TNN/ug3hJi+iZPH34=; b=fpslZXDbpYFgmB9XGtSe2wZiug
	vsEVwtE1I3FlXN55UIkci7ouD+45EW/DS6jbmkwUqPA2kb0AF6Ev5HBJl7dTTeHyk/EExYw+baQDz
	HxModFsF9GK4Int6LLUISDLHPUuhhgxR0sa0f+SbU3qnnVqwEjTokTheQYpMpCFqrwxI=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wsQd7-0002UX-0S;
	Fri, 07 Aug 2026 19:53:18 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <bvanassche@acm.org>) id 1wsQd5-0002UP-QS
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 07 Aug 2026 19:53:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=1vvzszOiG1OEGoUUJytVYmugCQ4FP1N1W709qvkoQ30=; b=jmD/pbYm+MwaUl2PlrQKlsAVTW
 zQLvFqXq/KkO7rL5gF9eA9EkNHiKeeQ3zxRDuAxk6rL2dA7gkOpYvS+z2WuncqEci92dgWIEI0gU1
 zQb0tYShDGm/uYFM+YANRkz1RvTgoNEjsM9PWXOSenzGDvD3Q5IRvgX+NzCZ6WSbfF8c=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=1vvzszOiG1OEGoUUJytVYmugCQ4FP1N1W709qvkoQ30=; b=e1ZqOjo9RRLy4R1yry9RoE8qKK
 PUFNNtqx3CmKjDVjbT6/hbYNJm3M0zFhLIhog2saRPU0rqa4ZV38UwS3TF3/irTxW536MVb5UEDr2
 oZV+kp8EQ706yL7NIv2aZK9/71BlSYaHXXeRehMITaTYNLt7/DluIcXiPGOMvfgait/E=;
Received: from 011.lax.mailroute.net ([199.89.1.14])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wsQd5-0006FU-7v for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 07 Aug 2026 19:53:17 +0000
Received: from localhost (localhost [127.0.0.1])
 by 011.lax.mailroute.net (Postfix) with ESMTP id 4hGvvp492Tz1XM6JY;
 Fri,  7 Aug 2026 19:53:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
 content-transfer-encoding:content-type:content-type:in-reply-to
 :from:from:content-language:references:subject:subject
 :user-agent:mime-version:date:date:message-id:received:received;
 s=mr01; t=1786132387; x=1788724388; bh=1vvzszOiG1OEGoUUJytVYmug
 CQ4FP1N1W709qvkoQ30=; b=rpLZ/o5w/vW4H2LaHlob8MqyqUYlzx9qz0P/jQl8
 t9pdyjrOS8IO9Mwe5MSJEQ4bsXPwz0R3nOQf7v2pPiaoZD0pr6Wm3eo05z6L8JX2
 2VH7lEJUIs8RVEj53kdKmn2FGxef/6Fk7SvFc6O+z1gHJRCyWt9yImR7Ut4hy6CR
 t1gJE7ksGAvPRhxIxO4zNC1NvkG0qxszDAilA2ENYx/WZbUoDpCL1GfoOExZ3bry
 EgdphscJtWAl/jeg17xAdjQB10PncaH9N/lsH4Q6+Gu+AucVK7HFq9xaaZTjXco9
 kwciI6remKP7+FHx/JKn0BuiHaSu7cJ1DmIQUyFIOib+vA==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id zijCIgGCLbM6; Fri,  7 Aug 2026 19:53:07 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: bvanassche@acm.org)
 by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4hGvvk0WNkz1XM6JX;
 Fri,  7 Aug 2026 19:53:05 +0000 (UTC)
Message-ID: <9bd3846c-f6f2-4e32-aa61-c8da830561bc@acm.org>
Date: Fri, 7 Aug 2026 12:53:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Steven Rostedt <rostedt@goodmis.org>
References: <31b06883a88b8169f2d9be8ac7303bfe14cf1530.1786122586.git.bvanassche@acm.org>
 <20260807153320.3d17e0be@gandalf.local.home>
Content-Language: en-US
In-Reply-To: <20260807153320.3d17e0be@gandalf.local.home>
X-Headers-End: 1wsQd5-0006FU-7v
Subject: Re: [f2fs-dev] [PATCH] f2fs: Fix multiple sparse warnings
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
From: Bart Van Assche via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Bart Van Assche <bvanassche@acm.org>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 8/7/26 12:33 PM, Steven Rostedt wrote:
> On Fri,  7 Aug 2026 10:10:56 -0700
> Bart Van Assche <bvanassche@acm.org> wrote:
> 
>> diff --git a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h
>> index 270c1a2c24c4..7f5ce92afe0f 100644
>> --- a/include/trace/events/f2fs.h
>> +++ b/include/trace/events/f2fs.h
>> @@ -1493,7 +1493,8 @@ DECLARE_EVENT_CLASS(f2fs_mmap,
>>   		show_dev_ino(__entry),
>>   		(unsigned long)__entry->index,
>>   		__print_flags(__entry->flags, "|", FAULT_FLAG_TRACE),
>> -		__print_flags(__entry->ret, "|", VM_FAULT_RESULT_TRACE))
>> +		__print_flags((__force unsigned long)__entry->ret, "|",
>> +			      VM_FAULT_RESULT_TRACE))
>>   );
>>   
>>   DEFINE_EVENT(f2fs_mmap, f2fs_filemap_fault,
> 
> The above shows up in the tracefs file for this event. Can you make sure
> libtraceevent still parses it fine? (Check with trace-cmd to see if it
> fails to parse the event).

Hi Steve,

This is what I found in include/trace/stages/stage3_trace_output.h:

#undef __print_flags
#define __print_flags(flag, delim, flag_array...)					\
	({										\
		static const struct trace_print_flags __flags[] =			\
			{ flag_array };							\
		trace_print_flags_seq(p, delim, flag, __flags, ARRAY_SIZE(__flags));	\
	})

I don't see #flag anywhere. trace_print_flags_seq() is a C function. Is
my understanding correct that the above change only suppresses a sparse
warning and also that it doesn't affect the tracing output in any way?

Please let me know if I misunderstood your question.

Thanks,

Bart.


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
