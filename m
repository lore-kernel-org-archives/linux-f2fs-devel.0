From: Chao Yu <chao@kernel.org>
Subject: Re: [PATCH] f2fs: return error number for quota_write
Date: Sun, 22 Oct 2017 23:01:44 +0800
Message-ID: <af1a6437-d301-3c05-9da5-617c6cc6974e@kernel.org>
References: <20171012231500.19489-1-jaegeuk@kernel.org>
 <f84b3522-f53d-d91a-464d-71c194dd5864@huawei.com>
 <20171016230444.GA94030@jaegeuk-macbookpro.roam.corp.google.com>
 <79d07284-167a-3b12-bed3-cea138ab4eb7@kernel.org>
 <20171017181749.GB10794@jaegeuk-macbookpro.roam.corp.google.com>
 <f7c99fe2-5920-1274-a6c2-0cc831b8aca3@huawei.com>
 <20171019190851.GB82186@jaegeuk-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
 helo=mx.sourceforge.net)
 by sfs-ml-4.v29.ch3.sourceforge.com with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
 (Exim 4.89) (envelope-from <chao@kernel.org>) id 1e6HlE-0003t8-Gv
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 22 Oct 2017 15:01:56 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
 (Exim 4.76) id 1e6HlD-00063p-O4
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 22 Oct 2017 15:01:56 +0000
In-Reply-To: <20171019190851.GB82186@jaegeuk-macbookpro.roam.corp.google.com>
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
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

On 2017/10/20 3:08, Jaegeuk Kim wrote:
> On 10/18, Chao Yu wrote:
>> On 2017/10/18 2:17, Jaegeuk Kim wrote:
>>> On 10/17, Chao Yu wrote:
>>>>
>>>>
>>>> On 2017/10/17 7:04, Jaegeuk Kim wrote:
>>>>> On 10/16, Chao Yu wrote:
>>>>>> Hi Jaegeuk,
>>>>>>
>>>>>> On 2017/10/13 7:15, Jaegeuk Kim wrote:
>>>>>>> This patch returns an error number to quota_write in order for quota to handle
>>>>>>> it correctly.
>>>>>>
>>>>>> We should return error number like __generic_file_write_iter, right? it
>>>>>> needs to return written bytes if we have written one page or more, otherwise
>>>>>> return error number feedbacked from write_begin.
>>>>>>
>>>>>> So how about reverting 4f31d26b0c17 ("f2fs: return wrong error number on
>>>>>> f2fs_quota_write")?
>>>>>
>>>>> I thought like that, but realized the code change is somewhat different between
>>>>> them.
>>>>
>>>> Hmm... main structure of codes here is copied from other file systems, is there
>>>> the same problem in *_quota_write of other file systems?
>>>>
>>>> BTW, it looks making below judgment condition being useless.
>>>>
>>>> 	if (len == towrite)
>>>> 		return 0;
>>>
>>> We need this to avoid needless inode updates. :P
>>
>> For err = 0 and len == towrite case, it more likes a bug of quota that passing
>> 0 in @len.
>>
>> :(, Oh, still didn't get that why there is difference in between reverting and
>> this fixing. Can you please explain more about this?
> 
> Ah, right. Let me just revert the original patch. :)

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,

> 
> Thanks,
> 

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
