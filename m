From: Sheng Yong <shengyong1@huawei.com>
Subject: Re: [RFC PATCH 5/5] fsck.f2fs: reconnect unreachable
 files to lost+found
Date: Wed, 7 Feb 2018 18:04:03 +0800
Message-ID: <1264e062-71c3-0e0c-fb57-3c424fca3f10@huawei.com>
References: <20180206043125.134191-1-shengyong1@huawei.com>
 <20180206043125.134191-6-shengyong1@huawei.com>
 <49dc523a-c44b-ef70-8aa9-2600f92d5f79@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.192]
 helo=mx.sourceforge.net)
 by sfs-ml-2.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <shengyong1@huawei.com>) id 1ejMaf-0003FZ-F2
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 07 Feb 2018 10:04:33 +0000
Received: from [45.249.212.32] (helo=huawei.com)
 by sfi-mx-2.v28.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 id 1ejMae-0002Tq-4c
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 07 Feb 2018 10:04:33 +0000
In-Reply-To: <49dc523a-c44b-ef70-8aa9-2600f92d5f79@huawei.com>
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
To: jaegeuk@kernel.org, yuchao0@huawei.com
Cc: heyunlei@huawei.com, miaoxie@huawei.com, linux-f2fs-devel@lists.sourceforge.net



On 2018/2/7 18:01, Sheng Yong wrote:
> 
[...]
>> +
>> +    /* lookup lost+found in root directory */
>> +    lpf_ino = f2fs_lookup(sbi, node, (u8 *) LPF, strlen(LPF));
> 
> The 4th parameter should be namelen but not strlen(LPF).
Sorry for the noise. The comment here is wrong :(
> 
[...]
>> +
>> +static int fsck_do_reconnect_file(struct f2fs_sb_info *sbi,
>> +                  struct f2fs_node *lpf,
>> +                  struct f2fs_node *fnode)
>> +{
>> +    char name[80];
>> +    size_t namelen;
>> +    nid_t ino = le32_to_cpu(fnode->footer.ino);
>> +    struct node_info ni;
>> +    int ret;
>> +
>> +    namelen = snprintf(name, 80, "%u", ino);
>> +    if (namelen >= 80)
>> +        /* ignore terminating '\0', should never happen */
>> +        namelen = 79;
>> +
>> +    if (f2fs_lookup(sbi, lpf, (u8 *) name, strlen(LPF))) {

The 4th parameter should be namelen but not strlen(LPF).

>> +        ASSERT_MSG("Name %s already exist in lost+found", name);
>> +        return -EEXIST;
>> +    }
>> +
[...]
>>


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
