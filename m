From: Yunlong Song <yunlong.song@huawei.com>
Subject: Re: [PATCH v4] fsck.f2fs: check and fix i_namelen to avoid double
 free
Date: Sat, 23 Dec 2017 11:40:03 +0800
Message-ID: <fc26fe9c-15fd-29cc-578a-ed5f7e906e88@huawei.com>
References: <1513319130-114230-1-git-send-email-yunlong.song@huawei.com>
 <1513603527-163036-1-git-send-email-yunlong.song@huawei.com>
 <cbf1ef8f-9347-3a4c-bac7-62173544068f@huawei.com>
 <1d02d383-434e-bf32-1940-ff2ef790868f@huawei.com>
 <7409e62c-cf8f-b5d3-9ec7-f22d1e3a5c7c@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <7409e62c-cf8f-b5d3-9ec7-f22d1e3a5c7c@huawei.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Chao Yu <yuchao0@huawei.com>, jaegeuk@kernel.org, chao@kernel.org, yunlong.song@icloud.com
Cc: miaoxie@huawei.com, bintian.wang@huawei.com, shengyong1@huawei.com, heyunlei@huawei.com, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

And there is en[namelen] = '\0', should fix namelen to its right value.

On 2017/12/23 11:35, Chao Yu wrote:
> On 2017/12/23 11:19, Yunlong Song wrote:
>> Double free problem:
>> Since ddr bit jump makes i_namelen a larger value (> 255)，when file is
>> not encrypted,
>> the convert_encrypted_name will memcpy out range of en[255], when en is
>> freed, there
>> will be double free problem.
> It looks there is only memcpy overflow problem here.
>
> Thanks,
>
>> On 2017/12/23 11:05, Chao Yu wrote:
>>> On 2017/12/18 21:25, Yunlong Song wrote:
>>>> v1 -> v2: use child_info to pass dentry namelen
>>>> v2 -> v3: check child != NULL to include the F2FS_FT_ORPHAN file type
>>>> v3 -> v4: fix the i_namelen problem of dump.f2fs、
>>> There is no commit log, so what do you mean about "avoid double free"?
>>>
>>> Other than that, looks good to me.
>>>
>>> Reviewed-by: Chao Yu <yuchao0@huawei.com>
>>>
>>> Thanks,
>>>
>>>
>>> .
>>>
>
> .
>

-- 
Thanks,
Yunlong Song
