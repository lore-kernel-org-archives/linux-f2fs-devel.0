From: Sheng Yong <shengyong1@huawei.com>
Subject: Re: [RFC PATCH 0/2] f2fs: introduce lost+found feature
Date: Sun, 11 Feb 2018 09:53:01 +0800
Message-ID: <75d0e560-9293-2671-3a92-d601bfde9981@huawei.com>
References: <20180206043118.134137-1-shengyong1@huawei.com>
 <20180210025006.GB6020@jaegeuk-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.191]
 helo=mx.sourceforge.net)
 by sfs-ml-1.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <shengyong1@huawei.com>) id 1ekgpg-0002Eu-48
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 11 Feb 2018 01:53:32 +0000
Received: from szxga04-in.huawei.com ([45.249.212.190] helo=huawei.com)
 by sfi-mx-1.v28.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 id 1ekgpe-0000Sa-Hb
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 11 Feb 2018 01:53:32 +0000
In-Reply-To: <20180210025006.GB6020@jaegeuk-macbookpro.roam.corp.google.com>
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
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: heyunlei@huawei.com, miaoxie@huawei.com, linux-f2fs-devel@lists.sourceforge.net

Hi, Jaegeuk

On 2018/2/10 10:50, Jaegeuk Kim wrote:
> On 02/06, Sheng Yong wrote:
>> This patchset introduces lost+found feature in f2fs. If the feature is
>> enabled, f2fs should avoid to encrypting root directory.
> 
> In that case, we need to add test_dummy_encryption likewise ext4.
> 
If the test_dummy_encryption is only used for some a testcase, I think
it's ok not to add it. The lost_found feature is not enabled by default,
so if we don't specify "-O lost_found" for mkfs, root directory is allowed
to be encrypted. If I miss something, please let me know :)

thanks,
Sheng

>>
>> For more information, please check the mail "f2fs-tools: introduce lost+
>> found feature".
>>
>> Thanks,
>> Sheng
>>
>> Sheng Yong (2):
>>    f2fs: clean up f2fs_sb_has_xxx functions
>>    f2fs: introduce lost+found feature
>>
>>   fs/f2fs/data.c    |  2 +-
>>   fs/f2fs/f2fs.h    | 53 +++++++++++++++--------------------------------------
>>   fs/f2fs/file.c    |  6 +++---
>>   fs/f2fs/segment.c |  4 ++--
>>   fs/f2fs/super.c   | 26 +++++++++++++++++++-------
>>   fs/f2fs/sysfs.c   |  4 ++--
>>   6 files changed, 42 insertions(+), 53 deletions(-)
>>
>> -- 
>> 2.11.0
> 
> .
> 


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
