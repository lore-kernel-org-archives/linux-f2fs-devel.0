From: Chao Yu <chao@kernel.org>
Subject: Re: [bug report] f2fs: use rb_*_cached friends
Date: Fri, 12 Oct 2018 22:31:31 +0800
Message-ID: <18330c93-63c1-ac3e-5b73-8513857ebc1f@kernel.org>
References: <20181011122342.GA23299@mwanda>
 <de7d9aa6-b828-f2d9-4568-bfc758fad9d0@kernel.org>
 <20181012141818.c2y7moxclp5xhv54@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <chao@kernel.org>) id 1gAyTg-0006es-2I
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 12 Oct 2018 14:31:44 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1gAyTd-001Fc7-6B
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 12 Oct 2018 14:31:44 +0000
In-Reply-To: <20181012141818.c2y7moxclp5xhv54@mwanda>
Content-Language: en-US
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: linux-f2fs-devel@lists.sourceforge.net

On 2018-10-12 22:18, Dan Carpenter wrote:
> On Fri, Oct 12, 2018 at 10:00:20PM +0800, Chao Yu wrote:
>>
>> So finally, we will initialize leftmost's value here, anyway, I think there is

Sorry, I mean 'there is no such place...'

>> such place we use an uninitialized variable.
>>
>> BTW, do we have any chance to detect such case in smatch?
>>
> 
> Thanks for taking a look at this!  I think that's probably a bit
> complicated for Smatch...

Alright, actually, the logic would be a little complicated. :)

Thanks,

> 
> regards,
> dan carpenter
> 
